`timescale 1 ps / 1 ps
// lib RSB_Lib
module design_1_wrapper
   (EXT_LEDS,
    EXT_DDR3_addr,
    EXT_DDR3_ba,
    EXT_DDR3_cas_n,
    EXT_DDR3_ck_n,
    EXT_DDR3_ck_p,
    EXT_DDR3_cke,
    EXT_DDR3_cs_n,
    EXT_DDR3_dm,
    EXT_DDR3_dq,
    EXT_DDR3_dqs_n,
    EXT_DDR3_dqs_p,
    EXT_DDR3_odt,
    EXT_DDR3_ras_n,
    EXT_DDR3_reset_n,
    EXT_DDR3_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    EXT_SYS_CLK_N,
    EXT_SYS_CLK_P,
    EXT_PCIE_REFCLK_P,
    EXT_PCIE_REFCLK_N,
    EXT_PCIE_rxn,
    EXT_PCIE_rxp,
    EXT_PCIE_txn,
    EXT_PCIE_txp,
    EXT_SYS_RST);
  output  [2:0] EXT_LEDS;
  inout  [13:0] EXT_DDR3_addr;
  inout   [2:0] EXT_DDR3_ba;
  inout         EXT_DDR3_cas_n;
  inout         EXT_DDR3_ck_n;
  inout         EXT_DDR3_ck_p;
  inout         EXT_DDR3_cke;
  inout         EXT_DDR3_cs_n;
  inout   [7:0] EXT_DDR3_dm;
  inout  [63:0] EXT_DDR3_dq;
  inout   [7:0] EXT_DDR3_dqs_n;
  inout   [7:0] EXT_DDR3_dqs_p;
  inout         EXT_DDR3_odt;
  inout         EXT_DDR3_ras_n;
  inout         EXT_DDR3_reset_n;
  inout         EXT_DDR3_we_n;
  inout         FIXED_IO_ddr_vrn;
  inout         FIXED_IO_ddr_vrp;
  inout [53:0]  FIXED_IO_mio;
  inout         FIXED_IO_ps_clk;
  inout         FIXED_IO_ps_porb;
  inout         FIXED_IO_ps_srstb;
  input         EXT_SYS_CLK_N;
  input         EXT_SYS_CLK_P;
  input         EXT_PCIE_REFCLK_P;
  input         EXT_PCIE_REFCLK_N;
  input   [3:0] EXT_PCIE_rxn;
  input   [3:0] EXT_PCIE_rxp;
  output  [3:0] EXT_PCIE_txn;
  output  [3:0] EXT_PCIE_txp;
  input         EXT_SYS_RST;

  wire mmcms_locked;
  wire pcie_mmcm_locked;
  wire ddr_mmcm_locked;
  wire pcie_refclk_100MHz;
  
  wire pcie_clk_125MHz;
  reg [27:0] pcie_clk_counter;
  wire ddr_clk_100MHz;
  reg [27:0] ddr_clk_counter;
  wire ddr_rst;
  
  assign EXT_LEDS = {pcie_clk_counter[27],pcie_mmcm_locked,ddr_mmcm_locked,~ddr_rst}; 
  always @(posedge pcie_clk_125MHz)
      pcie_clk_counter = pcie_clk_counter + 1;
  always @(posedge ddr_clk_100MHz)
      ddr_clk_counter = ddr_clk_counter + 1;
	  
  assign mmcms_locked = pcie_mmcm_locked & ddr_mmcm_locked;
 
  IBUFDS_GTE2 pcie_refclk_buf (.O(pcie_refclk_100MHz), .ODIV2(), .I(EXT_PCIE_REFCLK_P), .CEB(1'b0), .IB(EXT_PCIE_REFCLK_N));

  design_1 design_1_i
       (.EXT_DDR3_addr(EXT_DDR3_addr),
        .EXT_DDR3_ba(EXT_DDR3_ba),
        .EXT_DDR3_cas_n(EXT_DDR3_cas_n),
        .EXT_DDR3_ck_n(EXT_DDR3_ck_n),
        .EXT_DDR3_ck_p(EXT_DDR3_ck_p),
        .EXT_DDR3_cke(EXT_DDR3_cke),
        .EXT_DDR3_cs_n(EXT_DDR3_cs_n),
        .EXT_DDR3_dm(EXT_DDR3_dm),
        .EXT_DDR3_dq(EXT_DDR3_dq),
        .EXT_DDR3_dqs_n(EXT_DDR3_dqs_n),
        .EXT_DDR3_dqs_p(EXT_DDR3_dqs_p),
        .EXT_DDR3_odt(EXT_DDR3_odt),
        .EXT_DDR3_ras_n(EXT_DDR3_ras_n),
        .EXT_DDR3_reset_n(EXT_DDR3_reset_n),
        .EXT_DDR3_we_n(EXT_DDR3_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .EXT_SYS_CLK_clk_n(EXT_SYS_CLK_N),
        .EXT_SYS_CLK_clk_p(EXT_SYS_CLK_P),
        .EXT_PCIE_REFCLK_100MHz(pcie_refclk_100MHz),
        .EXT_PCIE_rxn(EXT_PCIE_rxn),
        .EXT_PCIE_rxp(EXT_PCIE_rxp),
        .EXT_PCIE_txn(EXT_PCIE_txn),
        .EXT_PCIE_txp(EXT_PCIE_txp),
        .EXT_SYS_RST(EXT_SYS_RST),
        .pcie_clk_125MHz(pcie_clk_125MHz),
        .ddr_clk_100MHz(ddr_clk_100MHz),
        .ddr_rst(ddr_rst),
        .pcie_mmcm_locked(pcie_mmcm_locked),
        .reset_logic_mmcm_locked_in(mmcms_locked),
        .ddr_rdy(ddr_mmcm_locked));
endmodule
