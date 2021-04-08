set dispScriptFile [file normalize [info script]]
set scriptFolder [file dirname $dispScriptFile]

create_project pcie-cdma-try1 $scriptFolder -part xc7z030sbg485-1
add_files -norecurse $scriptFolder/DesignWrapper.v
add_files -fileset constrs_1 -norecurse $scriptFolder/picozed_7z030_master_XDC_RevC_v2.xdc
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
set_property ip_repo_paths  $scriptFolder/ip_repo/ [current_project]
update_ip_catalog
source $scriptFolder/picozed030.2016.1.tcl
set_param general.maxThreads 8
launch_runs impl_1 -to_step write_bitstream -jobs 8
set run_list [list synth_1 impl_1] 
foreach myrun $run_list {wait_on_run $myrun}

