set dispScriptFile [file normalize [info script]]
set scriptFolder [file dirname $dispScriptFile]

create_project pcie-cdma-try1 $scriptFolder -part xc7z045ffg900-2
set_property BOARD_PART xilinx.com:zc706:part0:1.0 [current_project]
add_files -norecurse $scriptFolder/DesignWrapper.v
add_files -fileset constrs_1 -norecurse $scriptFolder/zc706Constraints.xdc
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
set_property ip_repo_paths  $scriptFolder/ip_repo/ [current_project]
update_ip_catalog
source $scriptFolder/zc706pl-ddr-pcie-cdma.2016.1.tcl
launch_runs impl_1 -to_step write_bitstream -jobs 4

