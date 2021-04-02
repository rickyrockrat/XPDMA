#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <stddef.h>
#include "xpdma.h"
#include <sys/time.h>
#include <sys/mman.h>  
#include <errno.h>
/**for page size  */
#include <unistd.h>
/** for open  */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
/**for memory access signal handling  */
#include <signal.h>
#include <setjmp.h>

#define TEST_SIZE   1024*1024*1024 // 1GB test data
#define TEST_ADDR   0 // offset of DDR start address
#define BOARD_ID    0 // board number (for multiple boards)
#ifndef _SC_PAGE_SIZE 
#define XPDMA_PAGE_SIZE _SC_PAGESIZE
#else
#define XPDMA_PAGE_SIZE _SC_PAGE_SIZE
#endif

struct mapper_mmap {
	int memfd;       /**file handle to opened memory device  */
	char *dev_path;  /** path to the memory device  */
	off_t mstart;      /** Start of memory to map  */
	uint64_t offset; /** Offset to start of the real memory in virtual address space  */
	uint64_t size;   /** Size of the memory map  */
	void *memory;    /** Virtal memory that corresponds to the 'real' memory. Use offset to get where you started.  */
	void *virt_addr; /** offset-adjusted value for memory. If offset=0, virt_addr=memory */
};


static sigjmp_buf bus_err, seg_fault;
/***************************************************************************/
/** 
@param 
@return 
****************************************************************************/
static void bus_handler (int sig, siginfo_t *siginfo, void *ptr)
{
	printf("busfault: si_code=%d\n", siginfo->si_code);
	siglongjmp (bus_err, 1);
}

/***************************************************************************/
/** @brief
@details.
@param 
@return 
****************************************************************************/
static void segfault_handler (int sig, siginfo_t *siginfo, void *ptr)
{
	printf("segfault@0x%08lX: si_code=%d si_errno=%d\n",
		(uint64_t)(siginfo->si_addr), siginfo->si_code,siginfo->si_errno);
	siglongjmp (seg_fault, 1);
}


/***************************************************************************/
/** @brief
@details Free the mapper_mmap structure.
@param 
@return 
****************************************************************************/
static void mapper_mmap_free (struct mapper_mmap *mm)
{
	if(NULL != mm->dev_path)
		free(mm->dev_path);
	free(mm);
} 

/***************************************************************************/
/** @brief
@details Unmap, close, and free mmap data structures.
@param mm - allocated map.
@return -1 on error, 0 on success.
****************************************************************************/
int mapper_mmap_close(struct mapper_mmap *mm)
{
	if( NULL == mm)	{
		printf("Attempting to close a mapper_mmap that is NULL\n");
		return -1;
	}
	if( MAP_FAILED != mm->memory && mm->size > 0)	{
		msync(mm->memory, mm->size, MS_SYNC);
		munmap(mm->memory, mm->size);
	}
		
	if(0<mm->memfd)
		close(mm->memfd);
	mapper_mmap_free(mm);
	return 0;
}

/***************************************************************************/
/** @brief
@details.
@param start is the starting address
@param size is the amount to map
@return 
****************************************************************************/
struct mapper_mmap *mapper_mmap_open (off_t start, uint64_t size) 
{
	struct mapper_mmap *mm=calloc(1,sizeof(struct mapper_mmap));
	struct sigaction action;
	uint32_t testv;
	size_t align;
	
	if(NULL == mm){
		printf("Out of Mem allocating mapper_mmap\n");
		return NULL;
	}
	memset (&action, 0, sizeof(action));
	action.sa_sigaction = bus_handler;
	action.sa_flags = SA_SIGINFO;
	if (sigaction(SIGBUS, &action, 0)) {
		printf("Unable to set sigaction on SIGBUS\n");
		goto err;
	}

	action.sa_sigaction = segfault_handler;
	if (sigaction(SIGSEGV, &action, 0)) {
		printf("Unable to set sigaction on SIGSEGV\n");
		goto err;
	}
	mm->dev_path=strdup("/dev/mem");
	
	if ( 0 > (mm->memfd = open(mm->dev_path, O_RDWR | O_SYNC)) ) {
		printf( "Can't open '%s'.\n",mm->dev_path);
		goto err;
	}
	printf("'%s' opened.  ",mm->dev_path);
	
	mm->size=size;
	mm->mstart=start & ~(sysconf(XPDMA_PAGE_SIZE) - 1);
	if(mm->mstart != start){
		printf("Starting memory is not page aligned. Adjusting %08llX to %08llX, and size from %d to %d\n",(unsigned long long)start, (unsigned long long)mm->mstart,size,mm->size);
		mm->offset=start-mm->mstart;
		mm->size+=start-mm->mstart;
	}else
		mm->offset=0;
	
	if (MAP_FAILED == (mm->memory = mmap(NULL, mm->size, PROT_READ | PROT_WRITE, MAP_SHARED, mm->memfd, mm->mstart )) ) {
		printf( "Error mapping %08llX, length %d to user space. (%s)\n", 
					(unsigned long long)mm->mstart, mm->size,strerror(errno));
		goto err;
	}
	
	mm->virt_addr = (void *)( ((uint64_t)(mm->memory)) + mm->offset);
	printf("Mapped 0x%08lX to 0x%08lX. Checking Access.\n",
		(uint64_t)start,(unsigned long)mm->virt_addr);
	
	/**verify we can access the address  */
	testv=*((uint32_t *)mm->virt_addr );
	printf("Lower Access OK ");
	fflush(NULL);
	align=(size_t)mm->virt_addr + (mm->size - sizeof(uint32_t)); 
	/**Word align it, in case it is an odd size.  */
	align=align/sizeof(uint32_t); 
	align*=sizeof(uint32_t);
	testv=*((uint32_t *)align); 
	
	printf("Upper Access OK: Mem map access OK\n");
	if (sigsetjmp(bus_err, 1)) {
		printf( "Sig Bus 0x%08X - 0x%08X\n",
			(unsigned int)mm->mstart,(unsigned int)(mm->mstart+mm->size));
		goto err;
	}
	if(sigsetjmp(seg_fault, 0)){
		printf( "Seg Fault Mapping 0x%08X - 0x%08X\n",
			(unsigned int)mm->mstart,(unsigned int)(mm->mstart+mm->size));
		goto err;
	}	
	
	printf("Memory at 0x%08lX - 0x%08lX mapped to address %p, offset %08X, Virt=%08lX.\n",
		(unsigned long)mm->mstart,(unsigned long)(mm->mstart+mm->size), mm->memory,
		mm->offset,(unsigned long)mm->virt_addr);
	return mm;
	
err:
	mapper_mmap_close(mm);
	return NULL;
} 


/***************************************************************************/
/** @brief
@details.
@param 
@return 
****************************************************************************/
int get_static_mem_value( int region, char *valname, uint64_t *val)
{
	char filename[100];
	FILE* file;
	int rtn=-1;
	
	snprintf(filename, 99,"/sys/bus/static_mem/devices/region%d/%s", region,valname);
	if(NULL == (file = fopen(filename,"r"))){
		printf("Error opening '%s'\n",filename);
		return -1;
	}
	if( fscanf(file,"0x%lx", val) <0 ){
		printf("Error reading file '%s' for region %d\n",filename,region);
		goto done;
	}
	rtn=0;
done:
	fclose(file);
	return rtn;
}

/***************************************************************************/
/** @brief
@details Read the static mem parameters, memmap them, and return the 
mapped address.
@param 
@return 
****************************************************************************/
struct mapper_mmap *setup_static_mem(int region, uint64_t *size, uint64_t *addr)
{
	if(-1 == get_static_mem_value(region,"addr",addr)) {
		printf("Can't get static mem addr 1\n");
		return NULL;
	}
	if(-1 == get_static_mem_value(region,"size",size)) {
		printf("Can't get static mem addr 1\n");
		return NULL;
	}
	printf("Region %d: %ld bytes @ 0x%08lX\n",region,*size,*addr);
	return mapper_mmap_open (*addr, *size);
}

void hex_printer(char *a, char *b, int len)
{
	int i, ia, ib,off;
	char buf[256], ba[5], bb[5];
	
	for (i=0; i<255;++i)
		buf[i]=' ';
	buf[11]='-';
	if(NULL == b)
		buf[16*3]=0;
	else
		buf[32*3]=0;
	printf("\n");
	for (ib=51, off=ia=i=0; i<len; ++i){
		sprintf(ba,"%02X",a[i]);
		if(NULL != b){
			sprintf(bb,"%02X",b[i]);
			buf[ib++]=bb[0];
			buf[ib++]=bb[1];
			++ib;
		}
			
		buf[ia++]=ba[0];
		buf[ia++]=ba[1];
		
		++ia;
		
		if(ia == 24) ++ia;
		if(ia >47){
			printf("%04X %s\n",off,buf);
			off+=16;
			ia=0;
			ib=51;
		}
	}
	printf("\n");
}


/***************************************************************************/
/** @brief
@details.
@param 
@return 
****************************************************************************/
void help (void )
{
	printf("Usage: test_xpdma <options>\n"
	" Where options are:\n"
	"  -h this screen\n"
	"  -m set mode m=use static mem r=read only w=write only\n"
	"  -s set size to transfer\n"
	"\n");
}
/**bit fields.  */
#define DO_READ			1
#define DO_WRITE		2
#define DO_STATIC_MEM	4

int main(int argc, char *argv[]) 
{
    xpdma_t * fpga;
	struct mapper_mmap *in, *out;
    uint64_t addr_in, addr_out, size, buf_size;
    uint32_t c = 0,  err_count = 0;
	int rtn, opt_size, mem_type, opt_mode=(DO_READ|DO_WRITE);;
    char *data_in;
    char *data_out;
    unsigned int len = 0;
    struct timeval _timers[4];
    double time_ms[4];
	
	in=out=NULL;
	data_in=data_out=NULL;
	size=buf_size=0;
	opt_size=TEST_SIZE;
	mem_type=0;
	rtn=1;
	while( -1 != (c = getopt(argc, argv, "hm:s:")) ) {
		switch(c){
			case 'h':
				help();
				return rtn;
				
			case 'm':
				switch(optarg[0]){
					case 'm':
						opt_mode|=DO_STATIC_MEM;
						mem_type=1;
						break;
					case 'r':
						opt_mode &=~(DO_READ|DO_WRITE);
						opt_mode |= DO_READ;
						break;
					case 'w':
						opt_mode &=~(DO_READ|DO_WRITE);
						opt_mode |= DO_WRITE;
						break;
					default:
						printf("Unknown -m mode %c\n",optarg[0]);
						return rtn;
						break;
				}
				break;
			case 's':
				opt_size=strtoul(optarg, NULL,0);
				break;
		}
	}
	

    printf("Open FPGA: ");
    fpga = xpdma_open(BOARD_ID);
    if (NULL == fpga) {
        printf ("Failed to open XPDMA device\n");
        return rtn;
    }
    printf("Successfull\n");
	if(opt_mode&DO_STATIC_MEM) {
		if(opt_mode & DO_WRITE){
			if( NULL == (in=setup_static_mem(0,&size,&addr_in)) ){
				return rtn;
			}	
			data_in=(char *)(in->virt_addr);
		} else
			size=opt_size;
		if(opt_mode & DO_READ){
			if( NULL == (out=setup_static_mem(1,&buf_size,&addr_out)) ){
				return rtn;
			}
			
			data_out=(char *)(out->virt_addr);
		}else 
			buf_size=opt_size;
		
		if( buf_size != size ) {
			if( buf_size > size) {
				printf("sizes do not match adjusting %d to %d\n",buf_size,size);
				buf_size=size;
			}
		}
		if(opt_size<size)
			size=buf_size=opt_size;
	}else {
		buf_size=size=opt_size;
		if(opt_mode&DO_WRITE) {
			data_in = (char *)malloc(opt_size);
			if (NULL == data_in) {
				printf ("Failed to allocate input buffer memory (size: %lu bytes)\n", buf_size);
				goto done;
			}
			addr_in=(uint64_t)data_in;
		}	
		if(opt_mode & DO_READ){
			data_out = (char *)malloc(opt_size);
			if (NULL == data_out) {
				printf ("Failed to allocate output buffer memory (size: %lu bytes)\n", buf_size);
				goto done;
			}
			addr_out=(uint64_t)data_out;
		}
	}
	
	if(opt_mode & DO_WRITE){
	    printf("Fill input data with %d bytes of data: ",buf_size);
		fflush(NULL);
		if(opt_mode & DO_STATIC_MEM){
			for (c = 0; c < buf_size; ++c)
		        //data_in[c] = rand()%256;
				((uint8_t *)data_in)[c] = (uint8_t)(c&0xFF);	
		}else{
			for (c = 0; c < buf_size/2;++c)
		        //data_in[c] = rand()%256;
				((uint16_t *)data_in)[c] = (uint16_t)(c&0xFFFF);
		}
	    
	    printf("Ok\n");
		printf("Send Data: ");
	    gettimeofday(&_timers[0], NULL);
	    xpdma_send(fpga, (void *)addr_in, buf_size, TEST_ADDR, mem_type); /**opt_mode of 1 happens to mean MEM_TYPE_KERN. FIXME  */
	    gettimeofday(&_timers[1], NULL);
	    printf("Ok\n");
	}
	if(opt_mode & DO_READ){
    	memset(data_out, 0, buf_size);

	    printf("Receive Data: ");
	    gettimeofday(&_timers[2], NULL);
	    xpdma_recv(fpga, (void *)addr_out, buf_size, TEST_ADDR, mem_type);
	    gettimeofday(&_timers[3], NULL);
	    printf("Ok\n");
	}	

    if((DO_READ|DO_WRITE) == (opt_mode &(DO_READ|DO_WRITE)) ){
		printf("Check Data: ");
		fflush(NULL);
	    for (c = 0; c < buf_size; ++c)
	        err_count += (data_in[c] != data_out[c]);
	
	    if (err_count){
			hex_printer(data_in,data_out,0x100);
			printf("%lu errors\n", err_count);
		} else
	        printf("Ok\n");	
	}else if( DO_READ & opt_mode){
		hex_printer(data_out,NULL,0x100);
	}
    
	rtn=0;
	

    for (c = 0; c < 4; ++c)
        time_ms[c] =
                ((double)_timers[c].tv_sec*1000.0) +
                ((double)_timers[c].tv_usec/1000.0);

    printf("Send speed: %f MB/s (%f ms)\n", buf_size/(1024*1024)/((time_ms[1] - time_ms[0])/1000.0), (time_ms[1] - time_ms[0]));
    printf("Recv speed: %f MB/s (%f ms)\n", buf_size/1024/1024/((time_ms[3] - time_ms[2])/1000.0), (time_ms[3] - time_ms[2]));
done:
	printf("Close FPGA\n");
    xpdma_close(fpga);
	fflush(NULL);
	if(opt_mode){
		mapper_mmap_close(in);
		mapper_mmap_close(out);	
	}else{
		free(data_in);
		free(data_out);
	}
    return rtn;
}
