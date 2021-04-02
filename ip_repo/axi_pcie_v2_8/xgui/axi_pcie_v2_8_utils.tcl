
namespace eval axi_pcie_v2_8_utils {

   proc upgrade_from_axi_pcie_v2_7 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray
      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray
      namespace forget ::xcoUpgradeLib::*
   }

   proc upgrade_from_axi_pcie_v2_6 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray
      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray
      namespace forget ::xcoUpgradeLib::*
   }

   proc upgrade_from_axi_pcie_v2_5 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray
      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray
      namespace forget ::xcoUpgradeLib::*
   }
 
   proc upgrade_from_axi_pcie_v2_4 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray

      set speed_gen2      [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set speedgrade      [string compare -nocase [getOption speedgrade valueArray] "-1"]
      set family          [string compare -nocase [getOption architecture valueArray] "artix7"]
      
      if {$family == 0 && $speed_gen2 == 0 && $speedgrade == 0 } { 
         setParameter MAX_LINK_SPEED "2.5_GT/s" valueArray  
      }

      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray

      namespace forget ::xcoUpgradeLib::*
   }
   
   proc upgrade_from_axi_pcie_v2_3 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray
      addParameter AXI_ACLK_LOOPBACK "true" valueArray
      setParameter AXI_ACLK_LOOPBACK "true" valueArray
      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray
      namespace forget ::xcoUpgradeLib::*
   }
   
   proc upgrade_from_axi_pcie_v2_2 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray
  
      addParameter AXI_ACLK_LOOPBACK "true" valueArray
      setParameter AXI_ACLK_LOOPBACK "true" valueArray

      set link_width_x4   [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set speed_gen2      [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set speedgrade      [string compare -nocase [getOption speedgrade valueArray] "-1"]
      set family          [string compare -nocase [getOption architecture valueArray] "artix7"]
      
      if {$family == 0 && $link_width_x4 == 0 && $speed_gen2 == 0 && $speedgrade == 0 } { 
         setParameter MAX_LINK_SPEED "2.5_GT/s" valueArray  
      }
 
      set lanewidth_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set artix_family [string compare -nocase [getOption architecture  valueArray] "artix7" ]
      if {$artix_family == 0  && $lanewidth_8 == 0} {
         setParameter  NO_OF_LANES "X1" valueArray
      }
         if {$artix_family == 0 && $lanewidth_8 == 0} {
         setParameter S_AXI_DATA_WIDTH "64" valueArray
      }
	if {$artix_family == 0 && $lanewidth_8 == 0} {
 	 setParameter M_AXI_DATA_WIDTH "64" valueArray
      }

      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray

      namespace forget ::xcoUpgradeLib::*
   }

   proc upgrade_from_axi_pcie_v2_1 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray

  	addParameter AXI_ACLK_LOOPBACK "true" valueArray
	setParameter AXI_ACLK_LOOPBACK "true" valueArray
      set link_width_x4   [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set speed_gen2      [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set speedgrade      [string compare -nocase [getOption speedgrade valueArray] "-1"]
      set family          [string compare -nocase [getOption architecture valueArray] "artix7"]
      
      if {$family == 0 && $link_width_x4 == 0 && $speed_gen2 == 0 && $speedgrade == 0 } { 
         setParameter MAX_LINK_SPEED "2.5_GT/s" valueArray  
      }
   
      set use_mode      [string compare -nocase [getParameter  PCIE_USE_MODE valueArray] "GES"]
      if {$use_mode == 0} {
         setParameter PCIE_USE_MODE "GES_and_Production" valueArray
      }
   
      set lanewidth_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set artix_family [string compare -nocase [getOption architecture  valueArray] "artix7" ]
      if {$artix_family == 0  && $lanewidth_8 == 0} {
         setParameter  NO_OF_LANES "X1" valueArray
      }
         if {$artix_family == 0 && $lanewidth_8 == 0} {
         setParameter S_AXI_DATA_WIDTH "64" valueArray
      }
	if {$artix_family == 0 && $lanewidth_8 == 0} {
 	 setParameter M_AXI_DATA_WIDTH "64" valueArray
      }

      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray

      namespace forget ::xcoUpgradeLib::*
   }

   proc upgrade_from_axi_pcie_v2_0 {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray

  	addParameter AXI_ACLK_LOOPBACK "true" valueArray
	setParameter AXI_ACLK_LOOPBACK "true" valueArray
      set link_width_x4   [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set speed_gen2      [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set speedgrade      [string compare -nocase [getOption speedgrade valueArray] "-1"]
      set family          [string compare -nocase [getOption architecture valueArray] "artix7"]
      
      if {$family == 0 && $link_width_x4 == 0 && $speed_gen2 == 0 && $speedgrade == 0 } { 
         setParameter MAX_LINK_SPEED "2.5_GT/s" valueArray  
      }

      set use_mode      [string compare -nocase [getParameter  PCIE_USE_MODE valueArray] "GES"]
      if {$use_mode == 0} {
         setParameter PCIE_USE_MODE "GES_and_Production" valueArray
      }

      set lane_width    [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set lane_width_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set gen2          [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set data_width_64 [string compare -nocase [getParameter S_AXI_DATA_WIDTH valueArray] "64"]

      if {$lane_width == 0 && $gen2 == 0 && $data_width_64 == 0} {
         setParameter S_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width == 0 && $gen2 == 0 && $data_width_64 == 0} {
         setParameter M_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width_8 == 0 && $data_width_64 == 0} {
         setParameter S_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width_8 == 0 && $data_width_64 == 0} {
         setParameter M_AXI_DATA_WIDTH "128" valueArray
      }
   
      set lanewidth_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set artix_family [string compare -nocase [getOption architecture  valueArray] "artix7" ]
      if {$artix_family == 0  && $lanewidth_8 == 0} {
         setParameter  NO_OF_LANES "X1" valueArray
      }
         if {$artix_family == 0 && $lanewidth_8 == 0} {
         setParameter S_AXI_DATA_WIDTH "64" valueArray
      }
	if {$artix_family == 0 && $lanewidth_8 == 0} {
 	 setParameter M_AXI_DATA_WIDTH "64" valueArray
      }

      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray

      namespace forget ::xcoUpgradeLib::*
   }

   proc upgrade_from_axi_pcie_v1_06_a {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray

  	addParameter AXI_ACLK_LOOPBACK "true" valueArray
	setParameter AXI_ACLK_LOOPBACK "true" valueArray
      set link_width_x4   [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set speed_gen2      [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set speedgrade      [string compare -nocase [getOption speedgrade valueArray] "-1"]
      set family          [string compare -nocase [getOption architecture valueArray] "artix7"]
      
      if {$family == 0 && $link_width_x4 == 0 && $speed_gen2 == 0 && $speedgrade == 0 } { 
         setParameter MAX_LINK_SPEED "2.5_GT/s" valueArray  
      }

      set use_mode      [string compare -nocase [getParameter  PCIE_USE_MODE valueArray] "GES"]
      if {$use_mode == 0} {
         setParameter PCIE_USE_MODE "GES_and_Production" valueArray
      }
 
      set lane_width    [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set lane_width_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set gen2          [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set data_width_64 [string compare -nocase [getParameter S_AXI_DATA_WIDTH valueArray] "64"]

      if {$lane_width == 0 && $gen2 == 0 && $data_width_64 == 0} {
         setParameter S_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width == 0 && $gen2 == 0 && $data_width_64 == 0} {
         setParameter M_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width_8 == 0 && $data_width_64 == 0} {
         setParameter S_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width_8 == 0 && $data_width_64 == 0} {
         setParameter M_AXI_DATA_WIDTH "128" valueArray
      }
     
      addParameter AXIBAR_NUM 1 valueArray

      set val 0
      for {set i 0} {$i<=5} {incr i} {
		if {[getParameter  AXI_BAR${i}_ENABLED valueArray] == "true"} {
			incr val
		}	
      }
      setParameter AXIBAR_NUM $val valueArray

      removeParameter AXI_BAR0_ENABLED valueArray
      removeParameter AXI_BAR1_ENABLED valueArray
      removeParameter AXI_BAR2_ENABLED valueArray
      removeParameter AXI_BAR3_ENABLED valueArray
      removeParameter AXI_BAR4_ENABLED valueArray
      removeParameter AXI_BAR5_ENABLED valueArray
   
      set lanewidth_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set artix_family [string compare -nocase [getOption architecture  valueArray] "artix7" ]
      if {$artix_family == 0  && $lanewidth_8 == 0} {
         setParameter  NO_OF_LANES "X1" valueArray
      }
         if {$artix_family == 0 && $lanewidth_8 == 0} {
         setParameter S_AXI_DATA_WIDTH "64" valueArray
      }
	if {$artix_family == 0 && $lanewidth_8 == 0} {
 	 setParameter M_AXI_DATA_WIDTH "64" valueArray
      }

      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray

      namespace forget ::xcoUpgradeLib::*
   }

   proc upgrade_from_axi_pcie_v1_05_a {xciValues} {
      namespace import ::xcoUpgradeLib::*
      upvar $xciValues valueArray

  	addParameter AXI_ACLK_LOOPBACK "true" valueArray
	setParameter AXI_ACLK_LOOPBACK "true" valueArray
      set link_width_x4   [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set speed_gen2      [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set speedgrade      [string compare -nocase [getOption speedgrade valueArray] "-1"]
      set family          [string compare -nocase [getOption architecture valueArray] "artix7"]
      
      if {$family == 0 && $link_width_x4 == 0 && $speed_gen2 == 0 && $speedgrade == 0 } { 
         setParameter MAX_LINK_SPEED "2.5_GT/s" valueArray  
      }

      set bar0_size     [string compare -nocase [getParameter BAR0_SIZE valueArray] "N/A"]
      set bar1_size     [string compare -nocase [getParameter BAR1_SIZE valueArray] "N/A"]
      set bar2_size     [string compare -nocase [getParameter BAR2_SIZE valueArray] "N/A"]

      if {$bar0_size == 0} {
         setParameter BAR0_SIZE "8" valueArray
      }
      if {$bar1_size == 0} {
         setParameter BAR1_SIZE "8" valueArray
      }
      if {$bar2_size == 0} {
         setParameter BAR2_SIZE "8" valueArray
      }

      set use_mode      [string compare -nocase [getParameter  PCIE_USE_MODE valueArray] "GES"]
      if {$use_mode == 0} {
         setParameter PCIE_USE_MODE "GES_and_Production" valueArray
      }
 
      set lane_width    [string compare -nocase [getParameter NO_OF_LANES valueArray] "X4"]
      set lane_width_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set gen2          [string compare -nocase [getParameter MAX_LINK_SPEED valueArray] "5.0_GT/s"]
      set data_width_64 [string compare -nocase [getParameter S_AXI_DATA_WIDTH valueArray] "64"]

      if {$lane_width == 0 && $gen2 == 0 && $data_width_64 == 0} {
         setParameter S_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width == 0 && $gen2 == 0 && $data_width_64 == 0} {
         setParameter M_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width_8 == 0 && $data_width_64 == 0} {
         setParameter S_AXI_DATA_WIDTH "128" valueArray
      }
      if {$lane_width_8 == 0 && $data_width_64 == 0} {
         setParameter M_AXI_DATA_WIDTH "128" valueArray
      }
     
      addParameter AXIBAR_NUM 1 valueArray

      set val 0
      for {set i 0} {$i<=5} {incr i} {
		if {[getParameter  AXI_BAR${i}_ENABLED valueArray] == "true"} {
			incr val
		}	
      }
      setParameter AXIBAR_NUM $val valueArray

      removeParameter AXI_BAR0_ENABLED valueArray
      removeParameter AXI_BAR1_ENABLED valueArray
      removeParameter AXI_BAR2_ENABLED valueArray
      removeParameter AXI_BAR3_ENABLED valueArray
      removeParameter AXI_BAR4_ENABLED valueArray
      removeParameter AXI_BAR5_ENABLED valueArray
   
      set lanewidth_8  [string compare -nocase [getParameter NO_OF_LANES valueArray] "X8"]
      set artix_family [string compare -nocase [getOption architecture  valueArray] "artix7" ]
      if {$artix_family == 0  && $lanewidth_8 == 0} {
         setParameter  NO_OF_LANES "X1" valueArray
      }
         if {$artix_family == 0 && $lanewidth_8 == 0} {
         setParameter S_AXI_DATA_WIDTH "64" valueArray
      }
	if {$artix_family == 0 && $lanewidth_8 == 0} {
 	 setParameter M_AXI_DATA_WIDTH "64" valueArray
      }

      addParameter SLOT_CLOCK_CONFIG "true" valueArray
      if {[getParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray] == "false"} {
        setParameter SLOT_CLOCK_CONFIG "false" valueArray 
      }
      removeParameter PCIE_CAP_SLOT_IMPLEMENTED valueArray

      namespace forget ::xcoUpgradeLib::*
   }

}

