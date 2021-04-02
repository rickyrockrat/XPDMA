# sys clock pins
#set_property VCCAUX_IO DONTCARE [get_ports EXT_SYS_CLK_P]
set_property IOSTANDARD DIFF_SSTL15 [get_ports EXT_SYS_CLK_P]
set_property PACKAGE_PIN H9 [get_ports EXT_SYS_CLK_P]

# PadFunction: IO_L13N_T2_MRCC_34 
#set_property VCCAUX_IO DONTCARE [get_ports EXT_SYS_CLK_N]
set_property IOSTANDARD DIFF_SSTL15 [get_ports EXT_SYS_CLK_N]
set_property PACKAGE_PIN G9 [get_ports EXT_SYS_CLK_N]

# Sys Reset Pins
set_property PACKAGE_PIN A8 [get_ports EXT_SYS_RST]
set_property IOSTANDARD LVCMOS15 [get_ports EXT_SYS_RST]
# PCIE_PERST
set_property PACKAGE_PIN AK23 [get_ports EXT_PCIE_PERST]
set_property IOSTANDARD LVCMOS25 [get_ports EXT_PCIE_PERST]
#PCIE_WAKE
set_property PACKAGE_PIN AK22 [get_ports EXT_PCIE_WAKE]
set_property IOSTANDARD LVCMOS25 [get_ports EXT_PCIE_WAKE]

# PCIe Refclk Pins
set_property PACKAGE_PIN N8 [get_ports EXT_PCIE_REFCLK_P]
set_property PACKAGE_PIN N7 [get_ports EXT_PCIE_REFCLK_N]
# PCIe TX RX Pins
#set_property PACKAGE_PIN T2 [get_ports {const_txp[2]}]
#set_property PACKAGE_PIN T1 [get_ports {const_txn[2]}]
#set_property PACKAGE_PIN R4 [get_ports {const_txp[1]}]
#set_property PACKAGE_PIN R3 [get_ports {const_txn[1]}]
#set_property PACKAGE_PIN P2 [get_ports {const_txp[0]}]
#set_property PACKAGE_PIN P1 [get_ports {const_txn[0]}]

set_property PACKAGE_PIN T2 [get_ports {EXT_PCIE_txp[3]}]
set_property PACKAGE_PIN T1 [get_ports {EXT_PCIE_txn[3]}]
set_property PACKAGE_PIN R4 [get_ports {EXT_PCIE_txp[2]}]
set_property PACKAGE_PIN R3 [get_ports {EXT_PCIE_txn[2]}]
set_property PACKAGE_PIN P2 [get_ports {EXT_PCIE_txp[1]}]
set_property PACKAGE_PIN P1 [get_ports {EXT_PCIE_txn[1]}]

set_property PACKAGE_PIN V6 [get_ports {EXT_PCIE_rxp[3]}]
set_property PACKAGE_PIN V5 [get_ports {EXT_PCIE_rxn[3]}]
set_property PACKAGE_PIN U4 [get_ports {EXT_PCIE_rxp[2]}]
set_property PACKAGE_PIN U3 [get_ports {EXT_PCIE_rxn[2]}]

set_property PACKAGE_PIN T6 [get_ports {EXT_PCIE_rxp[1]}]
set_property PACKAGE_PIN T5 [get_ports {EXT_PCIE_rxn[1]}]
set_property PACKAGE_PIN N4 [get_ports {EXT_PCIE_txp[0]}]
set_property PACKAGE_PIN N3 [get_ports {EXT_PCIE_txn[0]}]
set_property PACKAGE_PIN P6 [get_ports {EXT_PCIE_rxp[0]}]
set_property PACKAGE_PIN P5 [get_ports {EXT_PCIE_rxn[0]}]

#set_property IOSTANDARD LVCMOS15 [get_ports {const_txp}]
#set_property IOSTANDARD LVCMOS15 [get_ports {const_txn}]
#set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports {EXT_PCIE_rxp}]
#set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports {EXT_PCIE_rxn}]

# LED Pins
set_property PACKAGE_PIN W21 [get_ports {EXT_LEDS[0]}]
set_property PACKAGE_PIN G2 [get_ports {EXT_LEDS[1]}]
set_property PACKAGE_PIN Y21 [get_ports {EXT_LEDS[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {EXT_LEDS[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {EXT_LEDS[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {EXT_LEDS[2]}]

#PCIe
#set_property PACKAGE_PIN [get_ports {EXT_PCIE_REFCLK_100MHz}]
#set_property IOSTANDARD LVCMOS25 [get_ports {EXT_PCIE_REFCLK_100MHz}]
#set_property IOSTANDARD LVCMOS25 [get_ports {pcie_clk_125MHz}]
#set_property IOSTANDARD LVCMOS25 [get_ports {pcie_mmcm_locked}]


create_clock -period 10.000 -name ext_pcie_refclk -waveform {0.000 5.000} [get_pins pcie_refclk_buf/O]
#create_clock -period 10.000 -name int_pcie_refclk -waveform {0.000 5.000} [get_nets design_1_i/pcie_cdma_subsystem/axi_pcie_1/inst/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/refclk]
#create_clock -period 5.000 -name ext_sys_clk -waveform {0.000 2.500} [get_ports EXT_SYS_CLK_P]
set_false_path -through [get_nets {design_1_i/axi_peripheral_aresetn}]
set_false_path -through [get_nets {design_1_i/axi_interconnect_aresetn}]
set_false_path -to [get_pins design_1_i/pcie_cdma_subsystem/axi_pcie_1/inst/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/S*]
set_case_analysis 1 [get_pins {design_1_i/pcie_cdma_subsystem/axi_pcie_1/inst/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/S0}]
set_case_analysis 0 [get_pins {design_1_i/pcie_cdma_subsystem/axi_pcie_1/inst/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/S1}]

set_property LOC PCIE_X0Y0 [get_cells design_1_i/pcie_cdma_subsystem/axi_pcie_1/inst/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_i/pcie_7x_i/pcie_block_i]

# From the rdf-0287, pcie TRD
#-----------------------------------
# PCIe Transceiver & Core Locations 
#-----------------------------------

# PCIe Block Placement
#INST "z7_pcie_dma_top_i/pcie_inst/pcie_top_i/pcie_7x_i/pcie_block_i" LOC = PCIE_X0Y0;

# PCIe Lane 0
#INST "z7_pcie_dma_top_i/pcie_inst/gt_top_i/pipe_wrapper_i/pipe_lane[0].gt_wrapper_i/gtx_channel.gtxe2_channel_i" LOC = GTXE2_CHANNEL_X0Y15;
# PCIe Lane 1
#INST "z7_pcie_dma_top_i/pcie_inst/gt_top_i/pipe_wrapper_i/pipe_lane[1].gt_wrapper_i/gtx_channel.gtxe2_channel_i" LOC = GTXE2_CHANNEL_X0Y14;
# PCIe Lane 2
#INST "z7_pcie_dma_top_i/pcie_inst/gt_top_i/pipe_wrapper_i/pipe_lane[2].gt_wrapper_i/gtx_channel.gtxe2_channel_i" LOC = GTXE2_CHANNEL_X0Y13;
# PCIe Lane 3
#INST "z7_pcie_dma_top_i/pcie_inst/gt_top_i/pipe_wrapper_i/pipe_lane[3].gt_wrapper_i/gtx_channel.gtxe2_channel_i" LOC = GTXE2_CHANNEL_X0Y12;

#------------------------
# Clock and Reset Pinout
#------------------------

#NET "sys_rst_n" TIG;
#NET "sys_rst_n" LOC = AK23;
#NET "sys_rst_n" IOSTANDARD = LVCMOS25;

# 100 MHz Reference Clock
#INST "pcie_clk_ibuf" LOC = IBUFDS_GTE2_X0Y6;

#INST "z7_pcie_dma_top_i/ext_clk.pipe_clock_i/mmcm_i" LOC = MMCME2_ADV_X0Y4;

#NET "pcie_clk_p" LOC = N8;
#NET "pcie_clk_n" LOC = N7;

#// Lane 0 RXP/N and TXP/N Pin constraints
#NET "rx_n[0]" LOC = P5;
#NET "rx_p[0]" LOC = P6;
#NET "tx_n[0]" LOC = N3;
#NET "tx_p[0]" LOC = N4;

#// Lane 1 RXP/N and TXP/N Pin constraints
#NET "rx_n[1]" LOC = T5;
#NET "rx_p[1]" LOC = T6;
#NET "tx_n[1]" LOC = P1;
#NET "tx_p[1]" LOC = P2;

#// Lane 2-3 RXP/N and TXP/N Pin constraints
#NET "rx_n[2]" LOC = U3;
#NET "rx_p[2]" LOC = U4;
#NET "tx_n[2]" LOC = R3;
#NET "tx_p[2]" LOC = R4;
#NET "rx_n[3]" LOC = V5;
#NET "rx_p[3]" LOC = V6;
#NET "tx_n[3]" LOC = T1;
#NET "tx_p[3]" LOC = T2;



