proc init { cell_name undefined_params } {
  bd::mark_propagate_only [get_bd_cells $cell_name] {S_AXI_ID_WIDTH}
}

proc propagate { cell_name  undefined_params } { 

  set ip [get_bd_cells $cell_name]
  set si [get_bd_intf_pins $cell_name/S_AXI]

    set p {ID_WIDTH} 
    set si_v [get_property CONFIG.ID_WIDTH $si]
    set ip_v [get_property CONFIG.S_AXI_ID_WIDTH $ip]

    if {$si_v > 0} {
      set_property CONFIG.S_AXI_ID_WIDTH $si_v $ip
    } else {
      bd::send_msg -of $ip -type INFO -msg_id 3 -text " Preserving $p <$ip_v> "
    }

  set value [get_property CONFIG.SUPPORTS_NARROW_BURST $si]
  if { $value == 0 } {
    set_property CONFIG.S_AXI_SUPPORTS_NARROW_BURST false $ip
  } else {
    set_property CONFIG.S_AXI_SUPPORTS_NARROW_BURST true $ip
  }
}
proc set_base_high {ip} {
  set ::env(IPI_SET_BASE_HIGH) FALSE
  # base/high parameter
  set dDefValues [dict create \
  BAR0 [list 0x20000000 0x2FFFFFFF] \
  BAR1 [list 0x30000000 0x3FFFFFFF] \
  BAR2 [list 0x40000000 0x4FFFFFFF] \
  BAR3 [list 0x50000000 0x5FFFFFFF] \
  BAR4 [list 0x60000000 0x6FFFFFFF] \
  BAR5 [list 0x70000000 0x7FFFFFFF] \
  CTL0 [list 0x00000000 0x001FFFFF]]
  # Get slave interfaces and slave segments
  set vSlvBifs [get_bd_intf_pins -of_object $ip -quiet -filter {Mode == "Slave" && Name =~ "S_AXI*"}]
  set nSlvBifs [llength $vSlvBifs]
  #Get the slave segments related to the bifs
  set vSlvSegs [get_bd_addr_segs -of_objects $vSlvBifs]
  set nSlvSegs [llength $vSlvSegs]

  foreach slvSeg $vSlvSegs {
        #Get the name of the slave seg.
        set sSlvSeg [get_property name $slvSeg]

        set vDefValues [expr [dict exists $dDefValues $sSlvSeg] ? {[dict get $dDefValues $sSlvSeg]} : {[list 0xFFFFFFF 0x00000000]}]
        ::bd::addr::cfg_base_high_of_slv $ip $slvSeg [lindex $vDefValues 0] [lindex $vDefValues 1] 
   }
}
proc post_propagate { cell_name undefined_params } {
  set ip [get_bd_cells $cell_name]
  set clks [get_property CONFIG.axi_aclk_loopback $ip]	  
  set F true	  
  if {$clks == $F} {
  set aclk_out [get_bd_pins $cell_name/axi_aclk_out]
  set aclk     [get_bd_pins $cell_name/axi_aclk]
  set aclk_ctl_out [get_bd_pins $cell_name/axi_ctl_aclk_out]
  set aclk_ctl     [get_bd_pins $cell_name/axi_ctl_aclk]
  set aclk_out_domain [get_property CONFIG.CLK_DOMAIN $aclk_out]
  set aclk_domain     [get_property CONFIG.CLK_DOMAIN $aclk]
  set aclk_out_freq [get_property CONFIG.FREQ_HZ $aclk_out]
  set aclk_freq     [get_property CONFIG.FREQ_HZ $aclk]
  set aclk_out_phase [get_property CONFIG.PHASE $aclk_out]
  set aclk_phase     [get_property CONFIG.PHASE $aclk]
  if { $aclk_out_domain == $aclk_domain && $aclk_out_freq == $aclk_freq && $aclk_out_phase == $aclk_phase} {
    bd::send_msg -of $ip -type INFO -msg_id 1 -text " axi_aclk is connected to axi_aclk_out"
  } else {
    bd::send_msg -of $ip -type ERROR  -msg_id 1 -text " axi_aclk must be connected to axi_aclk_out"
  }
  set aclk_out_domain [get_property CONFIG.CLK_DOMAIN $aclk_ctl_out]
  set aclk_domain     [get_property CONFIG.CLK_DOMAIN $aclk_ctl]
  set aclk_out_freq [get_property CONFIG.FREQ_HZ $aclk_ctl_out]
  set aclk_freq     [get_property CONFIG.FREQ_HZ $aclk_ctl]
  set aclk_out_phase [get_property CONFIG.PHASE $aclk_ctl_out]
  set aclk_phase     [get_property CONFIG.PHASE $aclk_ctl]
  if { $aclk_out_domain == $aclk_domain && $aclk_out_freq == $aclk_freq && $aclk_out_phase == $aclk_phase} {
    bd::send_msg -of $ip -type INFO  -msg_id 2 -text " axi_ctl_aclk is connected to axi_ctl_aclk_out"
  } else {
    bd::send_msg -of $ip -type ERROR -msg_id 2 -text " axi_ctl_aclk must be connected to axi_ctl_aclk_out"
  }
  } else {
    bd::send_msg -of $ip -type INFO  -msg_id 1 -text " axi_aclk, axi_ctl_aclk are connected internally"
  }	  
  set_base_high $ip
}

proc post_config_ip {cell_name otherInfo} {
  set ip [get_bd_cells $cell_name]
  set clks [get_property CONFIG.axi_aclk_loopback $ip]	  
  set F true	  
  set clk_domain [get_property CONFIG.CLK_DOMAIN [get_bd_pins $cell_name/axi_aclk_out]]
  set_property CONFIG.CLK_DOMAIN $clk_domain [get_bd_pins $cell_name/axi_ctl_aclk_out]
  set lane [get_property CONFIG.NO_OF_LANES $ip]
  set speed [get_property CONFIG.MAX_LINK_SPEED $ip]
  set width [get_property CONFIG.S_AXI_DATA_WIDTH $ip]
  if {$lane == "X1" && $speed == "2.5_GT/s" && $width == "64"} {
   if {$clks == $F} {
   set_property CONFIG.FREQ_HZ 62500000 [get_bd_pins $cell_name/axi_aclk_out]
   set_property CONFIG.FREQ_HZ 62500000 [get_bd_pins $cell_name/axi_ctl_aclk_out]
   set_property CONFIG.FREQ_HZ 62500000 [get_bd_pins $cell_name/axi_aclk]
   set_property CONFIG.FREQ_HZ 62500000 [get_bd_pins $cell_name/axi_ctl_aclk]
   } else {
   set_property CONFIG.FREQ_HZ 62500000 [get_bd_pins $cell_name/axi_aclk_out]
   set_property CONFIG.FREQ_HZ 62500000 [get_bd_pins $cell_name/axi_ctl_aclk_out]
  } 
 } else {
   set_property CONFIG.FREQ_HZ 125000000 [get_bd_pins $cell_name/axi_aclk_out]
   set_property CONFIG.FREQ_HZ 125000000 [get_bd_pins $cell_name/axi_ctl_aclk_out]
  }

}
