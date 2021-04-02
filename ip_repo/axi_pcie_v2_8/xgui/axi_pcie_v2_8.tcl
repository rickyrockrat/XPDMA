proc EvalSubstituting {parameters procedure {numlevels 1}} {
    set paramlist {}
    if { [string index $numlevels 0]!="#"} {
        set numlevels [expr $numlevels+1]
    }
    foreach parameter $parameters {
        upvar 1 $parameter $parameter\_value
        tcl::lappend paramlist \$$parameter [set $parameter\_value]
    }
    uplevel $numlevels [string map $paramlist $procedure]
}

set part [get_project_property PART]
proc GetDevice {part} {
set device [get_project_property DEVICE]
	return $device
}
set device [GetDevice $part]
array set Base_Classes {
    "Device_was_built_before_Class_Code_definitions_were_finalized" "00"
    "Mass_storage_controller" "01"
    "Network_controller" "02"
    "Display_controller" "03"
    "Multimedia_device" "04"
    "Memory_controller" "05"
    "Bridge_device" "06"
    "Simple_communication_controllers" "07"
    "Base_system_peripherals" "08"
    "Input_devices" "09"
    "Docking_stations" "0A"
    "Processors" "0B"
    "Serial_bus_controllers" "0C"
    "Wireless_controller" "0D"
    "Intelligent_I/O_controllers" "0E"
    "Satellite_communication_controllers" "0F"
    "Encryption/Decryption_controllers" "10"
    "Data_acquisition_and_signal_processing_controllers" "11"
    "Device_does_not_fit_in_any_defined_classes" "FF"
}

array set Sub_Interfaces_00h {
   "All_currently_implemented_devices_except_VGA-compatible_devices" {00h 00h}
   "VGA-compatible_devices" {01h 00h}
}
array set Sub_Interfaces_01h {
   "SCSI_bus_controller" {00h 00h}
   "IDE_controller" {01h xx}
   "Floppy_disk_controller" {02h 00h}
   "IPI_bus_controller" {03h 00h}
   "RAID_controller" {04h 00h}
   "ATA_controller_with_ADMA_Interface_Single_Stepping " {05h 20h}
   "ATA_controller_with_ADMA_Interface_Continuous_Operation" {05h 30h}
   "Serial_ATA_controller_Vendor_Specific_Interface" {06h 00h}
   "Serial_ATA_controller_AHCI_1.0_Interface" {06h 01h}
   "Serial_Attached_SCSI(SAS)_Controller" {07h 00h}
   "Other_mass_storage_controller" {80h 00h}
}
array set Sub_Interfaces_02h {
   "Ethernet_controller" {00h 00h}
   "Token_Ring_controller" {01h 00h}
   "FDDI_controller" {02h 00h}
   "ATM_controller" {03h 00h}
   "ISDN_controller" {04h 00h}
   "WorldFip_controller" {05h 00h}
   "PICMG_2.14_Multi_Computing" {06h xx}
   "Other_network_controller" {80h 00h}
}
array set Sub_Interfaces_03h {
   "VGA_compatible_controller" {00h 00h}
   "8514_compatible_controller" {00h 01h}
   "XGA_controller" {01h 00h}
   "3D_controller" {02h 00h}
   "Other_display_controller" {80h 00h}
}
array set Sub_Interfaces_04h {
   "Video_device" {00h 00h}
   "Audio_device" {01h 00h}
   "Computer_telephony_device" {02h 00h}
   "Other_multimedia_device" {80h 00h}
}
array set Sub_Interfaces_05h {
   "RAM" {00h 00h}
   "Flash" {01h 00h}
   "Other_memory_controller" {80h 00h}
}
array set Sub_Interfaces_06h {
   "Host_bridge" {00h 00h}
   "ISA_bridge" {01h 00h}
   "EISA_bridge" {02h 00h}
   "MCA_bridge" {03h 00h}
   "PCI_to_PCI_bridge" {04h 00h}
   "Subtractive_Decode_PCI_to_PCI_bridge" {04h 01h}
   "PCMCIA_bridge" {05h 00h}
   "NuBus_bridge" {06h 00h}
   "CardBus_bridge" {07h 00h}
   "RACEway_bridge" {08h xx}
   "Semi_transparent_PCI_to_PCI_bridge_with_the_primary_PCI_bus_side_facing_the_system_host_processor" {09h 40h}
   "Semi_transparent_PCI_to_PCI_bridge_with_the_secondary_PCI_bus_side_facing_the_system_host_processor" {09h 80h}
   "InfiniBand_to_PCI_host_bridge" {0Ah 00h}
   "Other_bridge_device" {80h 00h}
}
array set Sub_Interfaces_07h {
   "Generic_XT_compatible_serial_controller" {00h 00h}
   "16450_compatible_serial_controller" {00h 01h}
   "16550_compatible_serial_controller" {00h 02h}
   "16650_compatible_serial_controller" {00h 03h}
   "16750_compatible_serial_controller" {00h 04h}
   "16850_compatible_serial_controller" {00h 05h}
   "16950_compatible_serial_controller" {00h 06h}
   "Parallel_port" {01h 00h}
   "Bi_directional_parallel_port" {01h 01h}
   "ECP_1.X_compliant_parallel_port" {01h 02h}
   "IEEE_1284_controller" {01h 03h}
   "IEEE_1284_target_device" {01h FEh}
   "Multiport_serial_controller" {02h 00h}
   "Generic_modem" {03h 00h}
   "Hayes_compatible_modem_with_16450_compatible_interface" {03h 01h}
   "Hayes_compatible_modem_with_16550_compatible_interface" {03h 02h}
   "Hayes_compatible_modem_with_16650_compatible_interface" {03h 03h}
   "Hayes_compatible_modem_with_16750_compatible_interface" {03h 04h}
   "GPIB(IEEE_488.1/2)_controller" {04h 00h}
   "Smard_Card" {05h 00h}
   "Other_communications_device" {80h 00h}
}
array set Sub_Interfaces_08h {
   "Generic_8259_PIC" {00h 00h}
   "ISA_PIC" {00h 01h}
   "EISA_PIC" {00h 02h}
   "I/O_APIC_interrupt_controller" {00h 10h}
   "I/Ox_APIC_interrupt_controller" {00h 20h}
   "Generic_8237_DMA_controller" {01h 00h}
   "ISA_DMA_controller" {01h 01h}
   "EISA_DMA_controller" {01h 02h}
   "Generic_8254_system_timer" {02h 00h}
   "ISA_system_timer" {02h 01h}
   "EISA_system_two_timers" {02h 02h}
   "Generic_RTC_controller" {03h 00h}
   "ISA_RTC_controller" {03h 01h}
   "Generic_PCI_Hot_Plug_controller" {04h 00h}
   "SD_Host_controller" {05h 00h}
   "Other_system_peripheral" {80h 00h}
}
array set Sub_Interfaces_09h {
   "Keyboard_controller" {00h 00h}
   "Digitizer_pen" {01h 00h}
   "Mouse_controller" {02h 00h}
   "Scanner_controller" {03h 00h}
   "Gameport_controller_generic" {04h 00h}
   "Gameport_controller" {04h 10h}
   "Other_input_controller" {80h 00h}
}
array set Sub_Interfaces_0Ah {
   "Generic_docking_station" {00h 00h}
   "Other_type_of_docking_station" {80h 00h}
}
array set Sub_Interfaces_0Bh {
   "386" {00h 00h}
   "486" {01h 00h}
   "Pentium" {02h 00h}
   "Alpha" {10h 00h}
   "PowerPC" {20h 00h}
   "MIPS" {30h 00h}
   "Co_processor" {40h 00h}
}
array set Sub_Interfaces_0Ch {
   "IEEE_1394_FireWire" {00h 00h}
   "IEEE_1394_following_the_1394_OpenHCI_specification" {00h 10h}
   "ACCESS_bus" {01h 00h}
   "SSA" {02h 00h}
   "Universal_Serial_Bus_following_the_Universal_Host_Controller_specification" {03h 00h}
   "Universal_Serial_Bus_following_the_Open_Host_Controller_specification" {03h 10h}
   "USB2_host_controller_following_the_Intel_Enhanced_Host_Controller_Interface" {03h 20h}
   "Universal_Serial_Bus_with_no_specific_programming_interface" {03h 80h}
   "USB_device_not_host_controller" {03h FEh}
   "Fibre_Channel" {04h 00h}
   "System_Management_Bus" {05h 00h}
   "InfiniBand" {06h 00h}
   "IPMI_SMIC_Interface" {07h 00h}
   "IPMI_Kybd_Controller_Style_Interface" {07h 01h}
   "IPMI_Block_Transfer_Interface" {07h 02h}
   "SERCOS_Interface_Standard(IEC_61491)" {08h 00h}
   "CANbus" {09h 00h}
}
array set Sub_Interfaces_0Dh {
   "iRDA_compatible_controller" {00h 00h}
   "Consumer_IR_controller" {01h 00h}
   "RF_controller" {10h 00h}
   "Bluetooth" {11h 00h}
   "Broadband" {12h 00h}
   "Ethernet(802.11a-5_GHz)" {20h 00h}
   "Ethernet(802.11b-2.4_GHz)" {21h 00h}
   "Other_type_of_wireless_controller" {80h 00h}
}
array set Sub_Interfaces_0Eh {
   "Message_FIFO_at_offset_040h" {00h 00h}
   "Intelligent_I/O_I2O_Architecture_Specification_1.0" {00h xx}
}
array set Sub_Interfaces_0Fh {
   "TV" {01h 00h}
   "Audio" {02h 00h}
   "Voice" {03h 00h}
   "Data" {04h 00h}
}
array set Sub_Interfaces_10h {
   "Network_and_computing_en/decryption" {00h 00h}
   "Entertainment_en/decryption" {10h 00h}
   "Other_en/decryption" {80h 00h}
}
array set Sub_Interfaces_11h {
   "DPIO_modules" {00h 00h}
   "Performance_counters" {01h 00h}
   "Communications_synchronization_plus_time_and_frequency_test/measurement" {10h 00h}
   "Management_card" {20h 00h}
   "Other_data_acquisition/signal_processing_controllers" {80h 00h}
}
array set Sub_Interfaces_12h {
   "Unknown" {xx xx}
}
array set Sub_Interfaces_FFh {
   "Unknown" {xx xx}
}

proc create_gui { IpView } {
	create_Page1 $IpView
	create_Page2 $IpView
	create_Page3 $IpView
	create_Page4 $IpView
	create_Page5 $IpView
	create_Page6 $IpView
	create_Page7 $IpView
	create_Page8 $IpView
	
}

proc create_Page1 {IpView} {
	variable device
	set Component_Name [ipgui::add_param $IpView -parent $IpView -name Component_Name]
	set Page1 [ipgui::add_page $IpView -parent $IpView -name Page1]
	set xlnxbord [ipgui::add_group $IpView -parent $Page1 -name "Xilinx Development Board"]
	set XLNX_REF_BOARD [ipgui::add_param $IpView -parent $xlnxbord -name XLNX_REF_BOARD  -widget  comboBox ]
	set_property display_name "Xilinx Development Board" $XLNX_REF_BOARD
	set_property display_name "PCIE:Basics" $Page1
	set PCIe_device_port [ipgui::add_group $IpView -parent $Page1 -name PCIe_device_port]
	set_property display_name "PCIe Device / Port Type" $PCIe_device_port
	ipgui::add_static_text $IpView -parent $PCIe_device_port -name PCI_Device_static_text -text "The Integrated Block for \
	PCI Express allows selection of the Device /	Port Type"
	set C_INCLUDE_RC [ipgui::add_param $IpView -parent $PCIe_device_port -name INCLUDE_RC -widget comboBox]
	set_property display_name "Device/Port Type" $C_INCLUDE_RC
	
	set ReferenceClockFrequency [ipgui::add_group $IpView -parent $Page1 -name ReferenceClockFrequency]
	set_property display_name "Reference Clock Frequency" $ReferenceClockFrequency	
	ipgui::add_static_text $IpView -parent $ReferenceClockFrequency -name Refrnce_clck_freqncy -text "The Integrated Block for PCI Express allows selection \
	of the reference clock frequency"
	set C_REF_CLK_FREQ [ipgui::add_param $IpView -parent $ReferenceClockFrequency -name REF_CLK_FREQ -widget comboBox] 
	 set_property display_name "Frequency (MHz)" $C_REF_CLK_FREQ
	set LinkStatusRe [ipgui::add_group $IpView -parent $Page1 -name LinkStatusRe]
	set_property display_name "Link Status Register" $LinkStatusRe	
	set C_SLOT_CLOCK_CONFIG [ipgui::add_param $IpView -parent $LinkStatusRe -name SLOT_CLOCK_CONFIG -widget checkBox] 
	set_property display_name "Enable Slot Clock Configuration" $C_SLOT_CLOCK_CONFIG
	set Silicon [ipgui::add_group $IpView -parent $Page1 -name Silicon]
	set_property display_name "Silicon" $Silicon
	set C_PCIE_USE_MODE [ipgui::add_param $IpView -parent $Silicon -name PCIE_USE_MODE -widget comboBox]
	set_property display_name "Silicon Revision" $C_PCIE_USE_MODE

        ipgui::add_row $IpView -parent $Page1

	set en_transceiver_status_ports [ipgui::add_param $IpView -parent $Page1 -name en_transceiver_status_ports]
	set_property display_name "Additional Transceiver Control and Status Ports" $en_transceiver_status_ports 

        ipgui::add_row $IpView -parent $Page1

        set en_ext_ch_gt_drp [ipgui::add_param $IpView -parent $Page1 -name en_ext_ch_gt_drp]
        set_property display_name "Enable External GT Channel DRP" $en_ext_ch_gt_drp
	
        set en_ext_pipe_interface [ipgui::add_param $IpView -parent $Page1 -name en_ext_pipe_interface]
        set_property display_name "Enable External PIPE Interface" $en_ext_pipe_interface

	###### Tool Tips ######
	set_property tooltip "Specifies the name of the HDL wrapper"  $Component_Name
	set_property tooltip "Indicates the type of PCI Express logical device. \nParameter : C_INCLUDE_RC"  $C_INCLUDE_RC
	set_property tooltip "Selects the frequency of the Reference clock provided on sys_clk.\n Parameter :C_REF_CLK_FREQ"  $C_REF_CLK_FREQ
	set_property tooltip "This field indicates that the Port uses the same physical reference clock that the \
	platform provides on the connector. \nParameter :C_SLOT_CLOCK_CONFIG"  $C_SLOT_CLOCK_CONFIG
	set_property tooltip "Specifies the target Silicon Revision. \nParameter :C_PCIE_USE_MODE"  $C_PCIE_USE_MODE
        set_property tooltip "When checked enables External GT Channel DRP Mode" [ipgui::get_paramspec -name en_ext_ch_gt_drp -of $IpView]
	
	### Initialising Xlnx_Ref_Board ###
	set device [string toupper [getDevice]]
	set package [string toupper [getPackage]]
        set family [string toupper [getDeviceFamily]]
    if {(($device == "XC7K325T" || $device == "XC7K325TL") && $package == "FFG900") || (($device == "XQ7K325T" || $device == "XQ7K325TL") && $package == "RF900")} {
		 set allowed {None KC705_REVA KC705_REVB KC705_REVC}
       set default "None"
	   set_property enabled true [ipgui::get_paramspec XLNX_REF_BOARD -of $IpView] 
    } elseif { $device == "XC7VX485T" && $package == "FFG1761"} {
			set allowed {None VC707}
	set default "None"
	    set_property enabled true [ipgui::get_paramspec XLNX_REF_BOARD -of $IpView] 
    } elseif { $device == "XC7Z045" && $package == "FFG900"} { 
			set allowed {None ZC706}
	set default "None"
	    set_property enabled true [ipgui::get_paramspec XLNX_REF_BOARD -of $IpView] 
    } elseif { $device == "XC7A200T" && $package == "FBG676"} { 
			set allowed {None AC701}
	set default "None"
	    set_property enabled true [ipgui::get_paramspec XLNX_REF_BOARD -of $IpView] 
    } else { 
       set allowed  {None} 
       set default "None"
       set_property enabled false [ipgui::get_paramspec XLNX_REF_BOARD -of $IpView] 
    }
	set allowed [join $allowed]
	set allowed [regsub -all " " $allowed ","]
	set_property range_value "$default,$allowed" [ipgui::get_paramspec XLNX_REF_BOARD -of $IpView] 
}

proc create_Page2 {IpView} {
	set Page2 [ipgui::add_page $IpView -parent $IpView -name Page2]
	set pcieblk [ipgui::add_group $IpView -parent $Page2 -name "PCIe Block Location"]
	set_property display_name "PCIE:Link Config" $Page2
	set PCIE_BLK_LOCN [ipgui::add_param $IpView -parent $pcieblk -name PCIE_BLK_LOCN  -widget  comboBox ]
	set_property display_name "PCIe Block Location" $PCIE_BLK_LOCN
	set No_of_lanes [ipgui::add_group $IpView -parent $Page2 -name No_of_lanes]
	set_property display_name "Number of Lanes" $No_of_lanes
	ipgui::add_static_text $IpView -parent $No_of_lanes -name No_of_Lanes_static_text -text \
	"The Integrated Block for PCI Express requires that an initial \lane width be selected. Wider \
	lane width \ncores can train down to smaller lane widths if attached to a smaller lane width device. \
	Select only the \nlane width that is necessary for the design."
	set C_NO_OF_LANES [ipgui::add_param $IpView -parent $No_of_lanes -name NO_OF_LANES -widget comboBox]
	set_property display_name "Lane Width" $C_NO_OF_LANES
	set grpBox [ipgui::add_group $IpView -parent $Page2 -name link_speed]
	set_property display_name "Link Speed" $grpBox
	ipgui::add_static_text -name text1 $IpView -parent $grpBox -text "The Integrated Block for PCI Express allows selection \
	of the Maximum Link Speed supported by the device"
	
	set C_MAX_LINK_SPEED [ipgui::add_param $IpView -parent $grpBox -name MAX_LINK_SPEED  -widget  comboBox ]
	set_property display_name "Link Speed" $C_MAX_LINK_SPEED 
	set_property tooltip "Selects the initial maximum link width of the device. \nParameter :C_NO_OF_LANES"  $C_NO_OF_LANES
	set_property tooltip "Selects the initial Maximum Link Speed of the device. \nParameter :C_MAX_LINK_SPEED"  $C_MAX_LINK_SPEED
	
	set device [string toupper [getDevice]]
	set package [string toupper [getPackage]]
        set family [string toupper [getDeviceFamily]]
        set c_xspeedgrade [getSpeedGrade]

	if {((($package == "FBG484") && ($family == "KINTEX7")) || ($family == "ARTIX7" || $device == "XC7Z030" ||  $device == "XC7Z030I" || $device == "XQ7Z030" || $device == "XA7Z030" || $device == "XC7Z015" || $device == "XC7Z015I"))} {
		if {($family == "ARTIX7") && ($package == "CPG236")} { 
			set_property range "X1,X2" $C_NO_OF_LANES
		} else {
			set_property range "X1,X2,X4" $C_NO_OF_LANES
                }
	} else {
		set_property range "X1,X2,X4,X8" $C_NO_OF_LANES
	}

}
			
proc create_Page3 {IpView} {
	set Page3 [ipgui::add_page $IpView -parent $IpView -name Page3]
	set_property display_name "PCIE:ID" $Page3
	set pf0_id_grp [ipgui::add_group $IpView -parent $Page3 -name pf0_id_grp -layout horizontal]
	set_property display_name "ID Initial Values" $pf0_id_grp
	set VENDOR_ID [ipgui::add_param $IpView -parent $pf0_id_grp -name VENDOR_ID]
	set_property display_name "Vendor ID" $VENDOR_ID
	ipgui::add_static_text $IpView -parent $pf0_id_grp -name vendor_range -text "Range: 0000 to FFFF"
	ipgui::add_row $IpView -parent $pf0_id_grp
	set DEVICE_ID  [ipgui::add_param $IpView -parent $pf0_id_grp -name DEVICE_ID ]
	set_property display_name "Device ID" $DEVICE_ID 
	ipgui::add_static_text $IpView -parent $pf0_id_grp -name device_range -text "Range: 0000 to FFFF"
	ipgui::add_row $IpView -parent $pf0_id_grp
	set PF0_REVISION_ID [ipgui::add_param $IpView -parent $pf0_id_grp -name REV_ID]
	set_property display_name "Revision ID" $PF0_REVISION_ID
	ipgui::add_static_text $IpView -parent $pf0_id_grp -name revision_range -text "Range: 00 to FF"
	ipgui::add_row $IpView -parent $pf0_id_grp
	set PF0_SUBSYSTEM_VENDOR_ID [ipgui::add_param $IpView -parent $pf0_id_grp -name SUBSYSTEM_VENDOR_ID]
	set_property display_name "Subsystem Vendor ID" $PF0_SUBSYSTEM_VENDOR_ID
	ipgui::add_static_text $IpView -parent $pf0_id_grp -name subsystemven_range -text "Range: 0000 to FFFF"
	ipgui::add_row $IpView -parent $pf0_id_grp
	set PF0_SUBSYSTEM_ID [ipgui::add_param $IpView -parent $pf0_id_grp -name SUBSYSTEM_ID]
	set_property display_name "Subsystem ID" $PF0_SUBSYSTEM_ID
	ipgui::add_static_text $IpView -parent $pf0_id_grp -name subsys_range -text "Range: 0000 to FFFF"
	
	set Pf0_class_code_grp [ipgui::add_group $IpView -parent $Page3 -name Pf0_class_code_grp -layout horizontal]
	set_property display_name "Class Code" $Pf0_class_code_grp
	ipgui::add_row $IpView -parent $Pf0_class_code_grp
	set ENABLE_CLASS_CODE [ipgui::add_param $IpView -parent $Pf0_class_code_grp -name ENABLE_CLASS_CODE -widget checkBox]
	set_property display_name "Enter Class Code Manually" $ENABLE_CLASS_CODE
	ipgui::add_row $IpView -parent $Pf0_class_code_grp
	set PF0_CLASS_CODE [ipgui::add_param $IpView -parent $Pf0_class_code_grp -name CLASS_CODE]
	set_property display_name "Class Code" $PF0_CLASS_CODE
	ipgui::add_static_text $IpView -parent $Pf0_class_code_grp -name class_range -text "Range: 000000 to FFFFFF"
	ipgui::add_row $IpView -parent $Pf0_class_code_grp

	set Class_code_lookup_grp [ipgui::add_group $IpView -parent $Pf0_class_code_grp -name Class_code_lookup_grp -layout horizontal]
	set_property display_name "Class Code Lookup Assistant" $Class_code_lookup_grp
    ipgui::add_static_text $IpView -parent $Class_code_lookup_grp -name class_code_lookup_static_text -text "Must enter values above."
	 ipgui::add_row $IpView -parent $Class_code_lookup_grp
	set pf0_base_class_menu [ipgui::add_param $IpView -parent $Class_code_lookup_grp -name BASE_CLASS_MENU -widget comboBox]
	set_property display_name "Base Class Menu" $pf0_base_class_menu
	ipgui::add_row $IpView -parent $Class_code_lookup_grp
	ipgui::add_static_text $IpView -parent $Class_code_lookup_grp -name base_class_static -text "Base Class Value"
	 ipgui::add_dynamic_text $IpView -parent $Class_code_lookup_grp -name pf0_base_class_value -tclproc "Base_Class_Value_updated"
	 ipgui::add_row $IpView -parent $Class_code_lookup_grp
	set pf0_sub_class_interface_menu [ipgui::add_param $IpView -parent $Class_code_lookup_grp -name SUB_CLASS_INTERFACE_MENU -widget comboBox]
	set_property display_name "Sub Class Interface Menu" $pf0_sub_class_interface_menu
	ipgui::add_row $IpView -parent $Class_code_lookup_grp
	ipgui::add_static_text $IpView -parent $Class_code_lookup_grp -name subclass_static -text "Sub Class Value"
	 ipgui::add_dynamic_text $IpView -parent $Class_code_lookup_grp -name pf0_sub_class_value -tclproc "Sub_Class_Value_updated"
	 ipgui::add_row $IpView -parent $Class_code_lookup_grp
	 ipgui::add_static_text $IpView -parent $Class_code_lookup_grp -name Interface_static -text "Interface Value"
	 ipgui::add_dynamic_text $IpView -parent $Class_code_lookup_grp -name pf0_interface_value -tclproc "Interface_Value_updated"	 
	set_property display_border true [ipgui::get_textspec pf0_base_class_value -of $IpView]
	set_property display_border true [ipgui::get_textspec pf0_sub_class_value -of $IpView]
	set_property display_border true [ipgui::get_textspec pf0_interface_value -of $IpView]
	set_property tooltip "This value identifies the vendor of the PCI Express device.  Vendor \
	ID values are assigned by the PCI-SIG. \nParameter :C_VENDOR_ID"  $VENDOR_ID
	set_property tooltip "This value identifies the PCI Express Device ID. Device ID values are \
	assigned by the vendor of the PCI Express device. \nParameter :C_DEVICE_ID"  $DEVICE_ID
	set_property tooltip "This value is used to identify the revision level of a PCI Express device. \
	If you should later revise your PCI Express device design, update this field. \nParameter :C_REVISION_ID"  $PF0_REVISION_ID
	set_property tooltip "This value is used to identify the Subsystem Vendor ID of a PCI Express device. Parameter: C_SUBSYSTEM_VENDOR_ID"  $PF0_SUBSYSTEM_VENDOR_ID
	set_property tooltip "This value is used to identify the Subsystem ID of a PCI Express device. \nParameter :C_SUBSYSTEM_ID"  $PF0_SUBSYSTEM_ID
	set_property tooltip "Provides the list of possible Base Class options"  $pf0_base_class_menu
	set_property tooltip "Provides a list of possible Sub-Class / Interface options for the selected Base Class"  $pf0_sub_class_interface_menu
	set_property tooltip "This value indicates the general function of a device.  The value is a concatenation \
	of the Base Class, Sub-Class, and Interface and forms the Device Class Code. \nParameter :C_CLASS_CODE"  $PF0_CLASS_CODE
}


proc create_Page4 {IpView} {
	set Page4 [ipgui::add_page $IpView -parent $IpView -name Page4]
    set_property display_name "PCIE:BARS" $Page4
	set pf0_base_addr_grp [ipgui::add_group $IpView -parent $Page4 -name pf0_base_addr_grp -layout horizontal]
	set_property display_name "Base Address Registers" $pf0_base_addr_grp
	ipgui::add_static_text $IpView -parent $pf0_base_addr_grp -name pf0_base_add_static_txt -text "Base Address Registers (BARs) serve two purposes.  \
	Initially, they serve as a mechanism for the device \nto request blocks of address space in the system memory map.  After the \
	BIOS or OS determines what \naddresses are to be assigned to the device, the Base Address Registers are programmed with these \
	\naddresses and the user implemented PCI-PCI bridge must use this information to perform address \ndecoding."
	ipgui::add_row $IpView -parent $pf0_base_addr_grp
	set rp_bar_hide [ipgui::add_param $IpView -parent $pf0_base_addr_grp -name rp_bar_hide -widget checkBox]
	set_property display_name "Hide RP BAR" $rp_bar_hide
        set_property tooltip "Hides RP BAR from CPU during enumeration"  $rp_bar_hide
	ipgui::add_row $IpView -parent $pf0_base_addr_grp
	set BAR_64BIT [ipgui::add_param $IpView -parent $pf0_base_addr_grp -name BAR_64BIT -widget checkBox]
	set_property display_name "BAR 64 bit Enabled" $BAR_64BIT
	ipgui::add_row $IpView -parent $pf0_base_addr_grp
	set panel_bars [ipgui::add_panel $IpView -parent $pf0_base_addr_grp -name panel_bars ]
	set panel_aximap [ipgui::add_panel $IpView -parent $pf0_base_addr_grp -name panel_aximap ]
	
	foreach i {0 1 2 } {
			EvalSubstituting { i } {
				set bar_$i_option_grp [ipgui::add_group $IpView -parent $panel_bars -name bar_$i_option_grp -layout horizontal]
				set_property display_name "BAR $i Options" $bar_$i_option_grp
				
				set pf0_bar$i_enabled [ipgui::add_param $IpView -parent $bar_$i_option_grp -name BAR$i_ENABLED -widget checkBox]
				set_property display_name "Bar$i" $pf0_bar$i_enabled
				set_property tooltip "Enables Physical Function of Bar $i to be used in the design."  [set pf0_bar$i_enabled]
				set pf0_bar$i_type [ipgui::add_param $IpView -parent $bar_$i_option_grp -name BAR$i_TYPE -widget comboBox]
				set_property display_name "Type" $pf0_bar$i_type
				set_property tooltip "A BAR may request only Memory space"  [set pf0_bar$i_type]
				ipgui::add_row $IpView -parent $bar_$i_option_grp
				set pf0_bar$i_size [ipgui::add_param $IpView -parent $bar_$i_option_grp -name BAR$i_SIZE -widget comboBox]
				set_property display_name "Size" $pf0_bar$i_size
				
				set pf0_bar$i_scale [ipgui::add_param $IpView -parent $bar_$i_option_grp -name BAR$i_SCALE -widget comboBox -show_label false ]
				set_property display_name "" $pf0_bar$i_scale
				set_property tooltip "The BAR size indicates how much address space is requested. \
				The minimum size for a Memory BAR is 128 bytes, but sizes smaller than 4 Kbytes are discouraged. \
				In most systems, I/O space is small and fragmented; if you must use an I/O BAR, you are encouraged \
				to use the smallest space possible"  $pf0_bar$i_scale 
				set_property tooltip "The BAR size indicates how much address space is requested.  The minimum size \
				for a Memory BAR is 8 Kbytes.  In most systems, I/O space is small and fragmented; if you must use an \
				I/O BAR, you are encouraged to use the smallest space possible"  $pf0_bar$i_size
			} 0
		}
				
		foreach i {0 1 2 } {
			EvalSubstituting { i } {
				set barmap_$i_option_grp [ipgui::add_group $IpView -parent $panel_aximap -name barmap_$i_option_grp ]
				set_property display_name "AXI BAR MAP $i Options" $barmap_$i_option_grp				
				set PCIEBAR2AXIBAR_$i [ipgui::add_param $IpView -parent $barmap_$i_option_grp -name PCIEBAR2AXIBAR_$i ]
				set_property display_name "AXI-PCIe BAR Translation" $PCIEBAR2AXIBAR_$i				
				set PCIEBAR2AXIBAR_$i_SEC [ipgui::add_param $IpView -parent $barmap_$i_option_grp -name PCIEBAR2AXIBAR_$i_SEC -widget comboBox]
				set_property range_value 1,1 [set PCIEBAR2AXIBAR_$i_SEC]
				set_property enabled false [set PCIEBAR2AXIBAR_$i_SEC]
				set_property visible false [set PCIEBAR2AXIBAR_$i_SEC]
				set_property tooltip "Address translation from PCI Express address map to AXI address map. \nParameter:  C_PCIEBAR2AXIBAR_$i" [set PCIEBAR2AXIBAR_$i]
				# set_property display_name "Bar$i" $pf0_bar$i_enabled
			} 0
		}
}

proc create_Page5 {IpView} {
	set Page5 [ipgui::add_page $IpView -parent $IpView -name Page5]
    set_property display_name "PCIE:Misc" $Page5
	set Interrupt_Capabilities [ipgui::add_group $IpView -parent $Page5 -name "Interrupt Capabilities"]
	set Interrupt_Settings [ipgui::add_group $IpView -parent $Interrupt_Capabilities -name "Legacy Interrupt Settings"]
	set MSI_Capabilities [ipgui::add_group $IpView -parent $Interrupt_Capabilities -name "MSI Capabilities"]
	set Completion_Timeout [ipgui::add_group $IpView -parent $Page5 -name "Completion Timeout Configuration"]
	set SlaveBridge_Registers [ipgui::add_group $IpView -parent $Page5 -name "Dynamic Slave Bridge Address Translation"]
	set INTERRUPT_PIN [ipgui::add_param $IpView -parent $Interrupt_Settings -name INTERRUPT_PIN -widget checkBox]
	set MSI_DECODE_ENABLED [ipgui::add_param  $IpView -parent  $MSI_Capabilities -name MSI_DECODE_ENABLED]
	set NUM_MSI_REQ [ipgui::add_param $IpView -parent $MSI_Capabilities -name NUM_MSI_REQ ]
	set COMP_TIMEOUT [ipgui::add_param $IpView -parent $Completion_Timeout -name COMP_TIMEOUT -widget comboBox]
	set INCLUDE_BAROFFSET_REG [ipgui::add_param $IpView -parent $SlaveBridge_Registers -name INCLUDE_BAROFFSET_REG -widget checkBox]
	set_property tooltip "Indicates the usage of Legacy Interrupt Messages. \nParameter: C_INTERRUPT_PIN" $INTERRUPT_PIN
	set_property tooltip "When enabled, incoming Memory Write packet with address \nequal to \"MSI Base\" will be decoded and reported \nin the Root Port Interrupt FIFO register" [ipgui::get_paramspec MSI_DECODE_ENABLED -of $IpView ]
	set_property display_name "Intercept and Decode Incoming MSI Packet" $MSI_DECODE_ENABLED
	set_property display_name "MSI Vectors Requested" $NUM_MSI_REQ				
	set_property display_name "Enable Dynamic Address Translation" $INCLUDE_BAROFFSET_REG				
	set_property tooltip "Indicates the number of MSI Vectors Requested  \nParameter: C_NUM_MSI_REQ" $NUM_MSI_REQ
	set_property tooltip "Select whether the completion timeout value is 50us or 50ms. \nParameter: C_COMP_TIMEOUT" $COMP_TIMEOUT
	set_property tooltip "Check to use registers for High-Order Address Translation on the Slave Bridge. \nParameter: C_INCLUDE_BAROFFSET_REG" $INCLUDE_BAROFFSET_REG
	set_property tooltip "Enables the processor to change the Slave Bridge Address Translation Registers dynamically via the AXI-LITE interface.\nParameter: C_INCLUDE_BAROFFSET_REG" $INCLUDE_BAROFFSET_REG
}

proc create_Page6 {IpView} {
	set Page6 [ipgui::add_page $IpView -parent $IpView -name Page6 -layout horizontal]
    set_property display_name "AXI:BARS" $Page6
    set dummyPanel [ipgui::add_panel $IpView -name dummyPanel -parent $Page6]
    set axibars [ipgui::add_param $IpView -name AXIBAR_NUM -parent $dummyPanel -widget comboBox]
    set_property display_name "Number of BAR's" $axibars
    ipgui::add_row $IpView -parent $Page6
	foreach i {0 1 2 3 4 5} {
		EvalSubstituting { i } {
			set axi_bar_$i_option_grp [ipgui::add_group $IpView -parent $Page6 -name axi_bar_$i_option_grp -layout horizontal]
			set_property display_name "BAR $i Options" $axi_bar_$i_option_grp
          set axi_bar$i_type [ipgui::add_param $IpView -parent $axi_bar_$i_option_grp -name AXIBAR_AS_$i -widget checkBox]
          set_property display_name "64-bit Enable" $axi_bar$i_type
          set_property tooltip "AXI BAR $i to be a 64-bit BAR. \n Parameter: C_AXIBAR_AS_$i" $axi_bar$i_type
          ipgui::add_row $IpView -parent $axi_bar_$i_option_grp
			set axi_bar$i_base [ipgui::add_param $IpView -parent $axi_bar_$i_option_grp -name AXIBAR_$i ]
			set_property display_name "Aperture Base Address" $axi_bar$i_base
			set_property tooltip "Specify the Aperture Base for AXI BAR $i (must be smaller than Aperture High Address). \nParameter:  C_AXIBAR_$i" $axi_bar$i_base
			ipgui::add_row $IpView -parent $axi_bar_$i_option_grp
			set axi_bar$i_high [ipgui::add_param $IpView -parent $axi_bar_$i_option_grp -name AXIBAR_HIGHADDR_$i ]
			set_property display_name "Aperture High Address" $axi_bar$i_high
			set_property tooltip "Specify the Aperture High for AXI BAR $i (must be greater than Aperture Base Address). \nParameter: C_AXIBAR_HIGHADDR_$i" $axi_bar$i_high
			ipgui::add_row $IpView -parent $axi_bar_$i_option_grp
			set axi_bar$i_map [ipgui::add_param $IpView -parent $axi_bar_$i_option_grp -name AXIBAR2PCIEBAR_$i]
			set_property display_name "AXI to PCIe Translation" $axi_bar$i_map
			set_property tooltip "Specify the PCIe BAR $i mapping from the AXI BAR $i. \nParameter:  C_AXIBAR2PCIEBAR_$i" $axi_bar$i_map
			
			if { $i == 1 || $i == 3 } {
			ipgui::add_row $IpView -parent $Page6
			}

		} 0
	}
}

proc create_Page7 {IpView} {
	set Page7 [ipgui::add_page $IpView -parent $IpView -name Page7 ]
    set_property display_name "AXI:System" $Page7
	set AXIAddressing [ipgui::add_group $IpView -parent $Page7 -name "AXI Addressing" -layout horizontal]
	set AXIInterconnectConfiguration [ipgui::add_group $IpView -parent $Page7 -name "AXI Interconnect Configuration" ]
	set BASEADDR [ipgui::add_param $IpView -parent $AXIAddressing -name BASEADDR] 
	ipgui::add_static_text $IpView -parent $AXIAddressing -name baseaddr_range -text "Range: 00000000 to FFFFFFFF"
	ipgui::add_row $IpView -parent $AXIAddressing
	set HIGHADDR [ipgui::add_param $IpView -parent $AXIAddressing -name HIGHADDR] 
	ipgui::add_static_text $IpView -parent $AXIAddressing -name highaddr_range -text "Range: 00000000 to FFFFFFFF"
	set S_AXI_ID_WIDTH [ipgui::add_param $IpView -parent $AXIInterconnectConfiguration -name S_AXI_ID_WIDTH ]
	set S_AXI_ADDR_WIDTH [ipgui::add_param $IpView -parent $AXIInterconnectConfiguration -name S_AXI_ADDR_WIDTH -widget textEdit]
	set S_AXI_DATA_WIDTH [ipgui::add_param $IpView -parent $AXIInterconnectConfiguration -name S_AXI_DATA_WIDTH -widget comboBox]
	set M_AXI_ADDR_WIDTH [ipgui::add_param $IpView -parent $AXIInterconnectConfiguration -name M_AXI_ADDR_WIDTH -widget textEdit]
	set M_AXI_DATA_WIDTH [ipgui::add_param $IpView -parent $AXIInterconnectConfiguration -name M_AXI_DATA_WIDTH -widget comboBox]
	set S_AXI_SUPPORTS_NARROW_BURST	[ipgui::add_param $IpView -parent $AXIInterconnectConfiguration -name S_AXI_SUPPORTS_NARROW_BURST -widget checkBox]
	  set_property enabled false $S_AXI_ADDR_WIDTH
	  set_property enabled false $M_AXI_ADDR_WIDTH
	  set_property tooltip "Specify the AXI Base Address for the device (Must be set to smaller value than HIGHADDR). \n Parameter: C_BASEADDR" $BASEADDR
	  set_property tooltip "Specify the AXI High Address range for the device (Must be set to higher value than BASEADDR \nParameter: C_HIGHADDR" $HIGHADDR
	  set_property tooltip "Specify the AXI Slave Port ID Width \nParameter: C_S_AXI_ID_WIDTH" $S_AXI_ID_WIDTH
	  set_property tooltip "Specifies the AXI Slave Port Address Width \nParameter: C_S_AXI_ADDR_WIDTH" $S_AXI_ADDR_WIDTH
	  set_property tooltip "Specify the AXI Slave Port Data Width \nParameter: C_S_AXI_DATA_WIDTH" $S_AXI_DATA_WIDTH
	  set_property tooltip "Specifies the AXI Master Port Address Width \nParameter: C_M_AXI_ADDR_WIDTH" $M_AXI_ADDR_WIDTH
	  set_property tooltip "Specify the AXI Master Port Data Width (Must be equal to S_AXI_DATA_WIDTH). \nParameter: C_M_AXI_DATA_WIDTH" $M_AXI_DATA_WIDTH
	  set_property tooltip "When selected, the IP supports narrow burst transfers.  When deselected, no AXI Masters should drive narrow \
	  burst and the IP is optimized with that understanding. \nParameter: C_S_AXI_SUPPORTS_NARROW_BURST" $S_AXI_SUPPORTS_NARROW_BURST	
}

proc create_Page8 {IpView} {

	set Page8 [ipgui::add_page $IpView -parent $IpView -name Page8 ]
		set_property display_name "Shared Logic" $Page8

		set Shared_Logic_group [ipgui::add_group $IpView -parent $Page8 -name Shared_Logic_group ]
		set_property display_name "Shared Logic" [ipgui::get_groupspec Shared_Logic_group -of $IpView]
		set Label [ipgui::add_static_text  $IpView -name Label -parent  $Shared_Logic_group -text "Select whether the Clocking and/or Transceiver GT_COMMON is included in the core itself or in the example design."]

		set shared_logic_in_core [ipgui::add_param  $IpView -parent $Shared_Logic_group -name shared_logic_in_core]
		set_property display_name "Include Shared Logic in core" $shared_logic_in_core

		set en_ext_clk [ipgui::add_param  $IpView -parent $Shared_Logic_group -name en_ext_clk]
		set_property display_name "Include Shared Logic (Clocking) in example design" $en_ext_clk

		set en_ext_gt_common [ipgui::add_param  $IpView -parent $Shared_Logic_group -name en_ext_gt_common]
		set_property display_name "Include Shared Logic (Transceiver GT_COMMON) in example design" $en_ext_gt_common

		ipgui::add_row $IpView -parent $Page8

		set shared_logic_info_group [ipgui::add_group $IpView -parent $Page8 -name "Shared Logic Overview" -layout vertical]
		ipgui::add_dynamic_text $IpView -name label_shared_logic -parent $shared_logic_info_group  -tclproc DT_Shared_Logic
		ipgui::add_image $IpView -name PixmapAFix2 -parent $shared_logic_info_group -width 450 -height 250
		set_property load_image "xgui/No_Shared_Logic.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]

		set_property tooltip "When checked includes shared logic in core." $shared_logic_in_core
		set_property tooltip "Indicates that the External Clocking block in example design is enabled." $en_ext_clk
		set_property tooltip "Indicates that the External Transceiver GT Common block in example design is enabled."  $en_ext_gt_common 
}

proc validate_BASEADDR { IpView} {
	return [RangeCheck4HexDec BASEADDR 0 FFFFFFFF $IpView]
}

proc validate_HIGHADDR { IpView} {
	return [RangeCheck4HexDec HIGHADDR 0 FFFFFFFF $IpView]
}

proc validate_VENDOR_ID { IpView} {
	return [RangeCheck4HexDec VENDOR_ID 0 FFFF $IpView]
}

proc validate_DEVICE_ID { IpView} {
	return [RangeCheck4HexDec DEVICE_ID 0 FFFF $IpView]
}

proc validate_REV_ID { IpView} {
	return [RangeCheck4HexDec REV_ID 0 FF $IpView]
}

proc validate_SUBSYSTEM_VENDOR_ID { IpView} {
	return [RangeCheck4HexDec SUBSYSTEM_VENDOR_ID 0 FFFF $IpView]
}

proc validate_SUBSYSTEM_ID { IpView} {
	return [RangeCheck4HexDec SUBSYSTEM_ID 0 FFFF $IpView]
}

proc validate_CLASS_CODE { IpView} {
	return [RangeCheck4HexDec CLASS_CODE 0 FFFFFF $IpView]
}

proc RangeCheck4HexDec {param MinValue MaxValue IpView} {
	set paramValue [string range  [get_param_value $param] 2 end]
	if { [regexp -all {[a-fA-F0-9]} $paramValue] != [ string length $paramValue ]} {
		set_property errmsg "Entered invalid Hexadecimal value $paramValue" [ipgui::get_paramspec $param	-of	$IpView ]
		return false
	}
	if {$paramValue  == ""} {
	 set_property errmsg "Entered invalid Hexadecimal value $paramValue" [ipgui::get_paramspec $param	-of	$IpView ]
	 return false
	}
	
	if {[expr 0x$MaxValue ] < [expr 0x$paramValue ] ||  [expr 0x$paramValue ] < [expr 0x$MinValue]} {
		set_property errmsg "Entered  Hexadecimal value $paramValue is out of range." [ipgui::get_paramspec $param	-of	$IpView ]
		return false
	}
	
	if {[string length $MaxValue]<[string length $paramValue]} {
		set_property errmsg "Entered  Hexadecimal value $paramValue is out of range." [ipgui::get_paramspec $param	-of	$IpView ]
		return false
	}
	return true
}


proc validate_M_AXI_DATA_WIDTH { IpView} {
	return [CheckDataWidth M_AXI_DATA_WIDTH $IpView]
}
proc CheckDataWidth {param IpView} {
	set paramValue [get_param_value $param] 
	set paramValue_SAXI [get_param_value S_AXI_DATA_WIDTH] 
	if {$paramValue  == "64" && $paramValue_SAXI == "128"} {
	 set_property errmsg "Entered invalid Data Widths on S-AXI and M-AXI data width, $paramValue bit" [ipgui::get_paramspec $param	-of	$IpView ]
	 return false
	}
	if {$paramValue  == "128" && $paramValue_SAXI == "64"} {
	 set_property errmsg "Entered invalid Data Widths on S-AXI and M-AXI data width, $paramValue bit" [ipgui::get_paramspec $param	-of	$IpView ]
	 return false
	}
	return true
}

proc getDevice {} {
	set device [get_project_property DEVICE]
                set name  [get_project_property PART]
                
                set Indx [string first $device $name]
                set Indx [expr "$Indx + [string length $device] -1"]
                return [string range $name 0 $Indx]

}

proc getPackage {} {
  set device [get_project_property DEVICE]
  set deviceName [get_project_property PART]
  set spd [get_project_property SPEEDGRADE]  
  set firstIndx [string first $device $deviceName]
  set firstIndx [expr { $firstIndx+[string length $device] } ]
  
  set lastIndx [string last $spd $deviceName  ]
  set lastIndx [expr {$lastIndx-1}]
  return [string range $deviceName $firstIndx $lastIndx]  
}

proc getDeviceFamily {} {
	return [get_project_property ARCHITECTURE]
}
proc getSpeedGrade {} {
	return [get_project_property SPEEDGRADE]
}

proc updateOfMAX_LINK_SPEED {IpView} {

	variable device
		variable package

	        set device [string toupper [getDevice]]
		set c_xfamily [getDeviceFamily]
		set c_xspeedgrade [getSpeedGrade]

		set MAX_LINK_SPEED [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
##switch models table 1.1.3.2 as closely as possible
		switch -glob -- [string tolower "$c_xfamily,$c_xspeedgrade,$device"] {

			"artix7,*,*" {
##All Artix7 parts
				if {([string tolower "$c_xspeedgrade"] == "-1") || ([string tolower "$c_xspeedgrade"] == "-1i") || ([string tolower "$c_xspeedgrade"] == "-1m") || ([string tolower "$c_xspeedgrade"] == "-1q") || ([string tolower "$c_xspeedgrade"] == "-1l") || ([string tolower "$c_xspeedgrade"] == "-1il")} {
				      set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView] 
				} else {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView] 
					} else {
                                                 if {$device == "XC7A35TL" || $device == "XC7A50TL" || $device == "XC7A75TL" || $device == "XC7A100TL" || $device == "XC7A200TL"} {
						     set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
                                                } else {
						     set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
                                                }
					}

				}
			}

			"kintex7,*,*" {

####All Kintex7 parts
				if {(([string tolower "$c_xspeedgrade"] == "-1") || ([string tolower "$c_xspeedgrade"] == "-1i") || ([string tolower "$c_xspeedgrade"] == "-1m") || ([string tolower "$c_xspeedgrade"] == "-1ml") )} {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView] 
					}  else {
                                           if {$device == "XC7K70TL" || $device == "XC7K160TL" || $device == "XC7K325TL" || $device == "XC7K355TL" || $device == "XC7K410TL" || $device == "XC7K420TL" || $device == "XC7K480TL" || $device == "XQ7K325TL" || $device == "XQ7K410TL" } { 
						set_property range_value "2.5_GT/s,2.5_GT/s"  [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
                                          }  else { 
						set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
                                          }
					}
				} else {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView] 
					} else { 
                                          if {$device == "XC7K70TL" || $device == "XC7K160TL" || $device == "XC7K325TL" || $device == "XC7K355TL" || $device == "XC7K410TL" || $device == "XC7K420TL" || $device == "XC7K480TL" || $device == "XQ7K325TL" || $device == "XQ7K410TL"} { 
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
                                          }  else { 
						set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
                                          }
					}
				}
			}

			"virtex7,*,*" {

#### All Virtex7 parts
				if {(([string tolower "$c_xspeedgrade"] == "-1") || ([string tolower "$c_xspeedgrade"] == "-1i") || ([string tolower "$c_xspeedgrade"] == "-1m"))} {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView] 
					} else {
						set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
					}
				} else {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]			
					} else { 
						set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]			
                                        }
                                }
}
          

			"zynq,*,*" {

##	All zynq parts
				if {([string tolower "$c_xspeedgrade"] == "-1") || ([string tolower "$c_xspeedgrade"] == "-1i") || ([string tolower "$c_xspeedgrade"] == "-1q") || ([string tolower "$c_xspeedgrade"] == "-1l" || ([string tolower "$c_xspeedgrade"] == "-1ql"))} {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
					} elseif {($device == "XC7Z015" || $device == "XC7Z015I")} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]
					} else {
						set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView] 					                                }
				} else {
					if {[get_param_value NO_OF_LANES] == "X8"} {
						set_property range_value "2.5_GT/s,2.5_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]				
				        } else { 
						set_property range_value "2.5_GT/s,2.5_GT/s,5.0_GT/s" [ipgui::get_paramspec MAX_LINK_SPEED -of $IpView]				
				        }
			         }
			}
			default {error "No match"}
}
}

proc updateOfPCIe_Blk_Locn {IpView} {
   set device [string toupper [getDevice]]
   set package [string toupper [getPackage]]
   set fmly [string toupper [getDeviceFamily]]
   set allowed {X0Y0 X0Y1 X0Y2 X1Y0 X1Y1}
   set updateInfo false
   set default "X0Y0"

	if {[get_param_value   XLNX_REF_BOARD  ] ne "None"} {
           set_property enabled false [ipgui::get_paramspec PCIE_BLK_LOCN -of $IpView] 
	} else {
            if {($fmly == "KINTEX7") || ($fmly == "ARTIX7") || ($fmly == "ZYNQ") } {
               set updateInfo true
               set default "X0Y0"
               set allowed {X0Y0}
             } elseif {($device == "XC7VX485T") || ($device == "XQ7VX485T")} {
	         if {($package == "FFG1157") || ($package == "FFG1761") || ($package == "FFG1930") || ($package == "RF1761") || ($package == "RF1930")} {
                   set updateInfo true
                   set default "X1Y0"
                   set allowed {X1Y0 X1Y1}
	         } elseif {($package == "FFG1158") || ($package == "FFG1927")} {
                    set updateInfo true
                    set default "X0Y0"
                    set allowed {X0Y0 X0Y1 X1Y0 X1Y1}
	         } 
             } elseif {($device == "XC7V585T") || ($device == "XQ7V585T")} {
	         if {($package == "FFG1157") || ($package == "RF1157")} {
                   set updateInfo true
                   set default "X0Y1"
                   set allowed {X0Y1 X0Y2}
	         } elseif {($package == "FFG1761") || ($package == "RF1761")} {
                    set updateInfo true
                    set default "X0Y0"
                    set allowed {X0Y0 X0Y1 X0Y2}
	         }
             } elseif {($device == "XC7V2000T")} {
	         if {($package == "FHG1761")} {
                   set updateInfo true
                   set default "X0Y0"
                   set allowed {X0Y0 X0Y1 X0Y2}
	         } elseif {($package == "FLG1925")} {
                    set updateInfo true
                    set default "X0Y0"
                    set allowed {X0Y0 X0Y1}
	         }
             } 
             if {$updateInfo == true } {
				set allowed [join $allowed]
				set allowed [regsub -all " " $allowed ","]
				set_property enabled true [ipgui::get_paramspec PCIE_BLK_LOCN -of $IpView] 
				set_property range_value "$default,$allowed" [ipgui::get_paramspec PCIE_BLK_LOCN -of $IpView] 
             }
	}
}

proc XLNX_REF_BOARD_updated {IpView} {
	updateOfPCIe_Blk_Locn $IpView
}

proc updateOfINTERRUPT_PIN {IpView} {
	if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
		set_property enabled true [ipgui::get_paramspec  INTERRUPT_PIN -of $IpView]
	} else {
		set_property enabled false [ipgui::get_paramspec  INTERRUPT_PIN -of $IpView]
		set_property value false [ipgui::get_paramspec  INTERRUPT_PIN -of $IpView]
	}
}

proc updateOfS_AXI_DATA_WIDTH {ipview} {
	if {([get_param_value MAX_LINK_SPEED] == "2.5_GT/s"&& [get_param_value  NO_OF_LANES ] == "X8") \
   || ( [get_param_value MAX_LINK_SPEED] == "5.0_GT/s"&& [get_param_value  NO_OF_LANES ] == "X4")} {
		set_property range_value 128,128 [ipgui::get_paramspec S_AXI_DATA_WIDTH -of $ipview]
	} else {
		set_property range 64,128 [ipgui::get_paramspec S_AXI_DATA_WIDTH -of $ipview]
	}

}

proc updateOfM_AXI_DATA_WIDTH {ipview} {
	if {([get_param_value MAX_LINK_SPEED] == "2.5_GT/s"&& [get_param_value  NO_OF_LANES ] == "X8") \
   || ( [get_param_value MAX_LINK_SPEED] == "5.0_GT/s"&& [get_param_value  NO_OF_LANES ] == "X4")} {
		set_property range_value 128,128 [ipgui::get_paramspec M_AXI_DATA_WIDTH -of $ipview]
	} else {
		set_property range 64,128 [ipgui::get_paramspec M_AXI_DATA_WIDTH -of $ipview]
	}

}

proc updateOfDEVICE_ID {IpView} {
    set device_port_type [get_param_value INCLUDE_RC]
    set LINK_SPEED [get_param_value MAX_LINK_SPEED]
    set LINK_WIDTH [get_param_value  NO_OF_LANES ]
    set speed_val 1
    set width 8
    # Assigning the default values
    set port [ expr {$device_port_type eq "Root_Port_of_PCI_Express_Root_Complex" }]
    switch $LINK_SPEED {
        "2.5_GT/s" {set speed_val 1}
        "5.0_GT/s" {set speed_val 2}
    }

    switch $LINK_WIDTH {
        "X1" { set width 1}
        "X2" { set width 2}
        "X4" { set width 4}
        "X8" { set width 8}
    }
    set_property value  0x7${port}${speed_val}${width} [ipgui::get_paramspec -name DEVICE_ID -of $IpView]
}

proc updateOfSUBSYSTEM_VENDOR_ID {IpView} {
	if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
		set_property enabled true [ipgui::get_paramspec -name SUBSYSTEM_VENDOR_ID -of $IpView]
	} else {
		set_property enabled false [ipgui::get_paramspec -name SUBSYSTEM_VENDOR_ID -of $IpView]
	}
}

proc updateOfSUBSYSTEM_ID  {IpView} {
	if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
		set_property enabled true [ipgui::get_paramspec -name SUBSYSTEM_ID -of $IpView]
	} else {
		set_property enabled false [ipgui::get_paramspec -name SUBSYSTEM_ID  -of $IpView]
	}
}

proc updateOfCLASS_CODE  {IpView} {
	if {[get_param_value ENABLE_CLASS_CODE] == "true"} {
		set_property enabled true [ipgui::get_paramspec -name CLASS_CODE  -of $IpView]
	} else {
		set_property enabled false [ipgui::get_paramspec -name CLASS_CODE  -of $IpView]
		set val [string map {h ""} [Base_Class_Value_updated $IpView][Sub_Class_Value_updated $IpView][Interface_Value_updated $IpView]]
		set_property value 0x$val [ipgui::get_paramspec -name CLASS_CODE  -of $IpView]
	}
}

proc updateOfBASE_CLASS_MENU  {IpView} {
	set list "Device_was_built_before_Class_Code_definitions_were_finalized,Mass_storage_controller,Network_controller, \
	Display_controller,Multimedia_device,Memory_controller,Simple_communication_controllers,Base_system_peripherals,	
    Input_devices,Docking_stations,Processors,Serial_bus_controllers,Wireless_controller,Intelligent_I/O_controllers,
    Satellite_communication_controllers"
	if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
		set_property enabled true [ipgui::get_paramspec -name BASE_CLASS_MENU -of $IpView]
		set_property range_value Memory_controller,$list [ipgui::get_paramspec -name BASE_CLASS_MENU  -of $IpView]
	} else {
		set_property enabled false [ipgui::get_paramspec -name BASE_CLASS_MENU  -of $IpView]
		set_property range_value Bridge_device,Bridge_device [ipgui::get_paramspec -name BASE_CLASS_MENU  -of $IpView]
	}
}

proc NO_OF_LANES_updated {IpView} {
	updateOfMAX_LINK_SPEED $IpView
	updateOfDEVICE_ID $IpView
	updateOfS_AXI_DATA_WIDTH $IpView
	updateOfM_AXI_DATA_WIDTH $IpView

}

proc ENABLE_CLASS_CODE_updated {IpView} {
	updateOfCLASS_CODE $IpView
}

proc INCLUDE_RC_updated {IpView} {
	for {set i 1} {$i<=2} {incr i} {
		if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
			set_property visible  true [ipgui::get_groupspec -name bar_${i}_option_grp -of $IpView]
			set_property visible  true [ipgui::get_groupspec -name barmap_${i}_option_grp -of $IpView]
		} else {
			set_property visible  false [ipgui::get_groupspec -name bar_${i}_option_grp -of $IpView]
			set_property visible  false [ipgui::get_groupspec -name barmap_${i}_option_grp -of $IpView]
		}
	}

	if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
		set_property visible  false [ipgui::get_paramspec -name rp_bar_hide -of $IpView]
                set_property visible  false [ipgui::get_paramspec -name MSI_DECODE_ENABLED -of $IpView]
	} else {
		set_property visible  true [ipgui::get_paramspec -name rp_bar_hide -of $IpView]
                set_property visible  true [ipgui::get_paramspec -name MSI_DECODE_ENABLED -of $IpView]
	}
	
	updateOfDEVICE_ID $IpView
	updateOfSUBSYSTEM_VENDOR_ID $IpView
	updateOfSUBSYSTEM_ID $IpView
	updateOfBASE_CLASS_MENU $IpView
	updateOfINTERRUPT_PIN $IpView
        updateOf_en_ext_clk $IpView
        updateOf_en_ext_gt_common $IpView
        updateOf_shared_logic_in_core $IpView 
        updateOf_PCIEBAR2AXIBAR_0 $IpView
        updateOfBAR0_SIZE $IpView
}

proc PCIE_USE_MODE_updated {IpView} {
        updateOf_en_ext_clk $IpView
        updateOf_en_ext_gt_common $IpView
        updateOf_shared_logic_in_core $IpView 
}


proc MAX_LINK_SPEED_updated {IpView} {
	 updateOfDEVICE_ID $IpView
  updateOfS_AXI_DATA_WIDTH $IpView
  updateOfM_AXI_DATA_WIDTH $IpView

}


proc Class_Code_Value_updated {IpView} {
	# This is a 24 bit value, represented in Hex. The 24 bit value comprises of:
	# 23:16	Class_Code_Base
	# 15:8	Class_Code_Sub
	# 7:0 	Class_Code_Interface
	set value [expr "0x[get_param_value Class_Code_Interface] | 0x[get_param_value Class_Code_Sub]00 | 0x[get_param_value Class_Code_Base]0000" ]
	return "[format %06X $value]"
}

proc Base_Class_Value_updated {IpView} {
	variable Base_Classes
	set base_code $Base_Classes([get_param_value   BASE_CLASS_MENU  ])
	return "${base_code}h"
}

proc Sub_Class_Value_updated {IpView} {
	variable Base_Classes
	set base_code $Base_Classes([get_param_value BASE_CLASS_MENU])
	variable Sub_Interfaces_${base_code}h
	return [lindex [set Sub_Interfaces_${base_code}h([get_param_value SUB_CLASS_INTERFACE_MENU])] 0]
}


proc BASE_CLASS_MENU_updated {IpView} {
	variable Base_Classes	
	set base_name [get_param_value   BASE_CLASS_MENU  ]
	set base_code $Base_Classes($base_name)
	variable Sub_Interfaces_${base_code}h
	set Sub_Interface_List [array names Sub_Interfaces_${base_code}h]
	#set curValue [lindex $Sub_Interface_List 0]
	set Sub_Interface_List [join $Sub_Interface_List]
	set Sub_Interface_List [regsub -all " " $Sub_Interface_List ","]
	set_property range "$Sub_Interface_List" [ipgui::get_paramspec SUB_CLASS_INTERFACE_MENU -of $IpView]  
	updateOfCLASS_CODE $IpView

}


proc SUB_CLASS_INTERFACE_MENU_updated {IpView} {
	updateOfCLASS_CODE $IpView
}

proc Interface_Value_updated {IpView} {
	variable Base_Classes
	set base_code $Base_Classes([get_param_value BASE_CLASS_MENU])
	variable Sub_Interfaces_${base_code}h
	return [lindex [set Sub_Interfaces_${base_code}h([get_param_value SUB_CLASS_INTERFACE_MENU])] 1]
}

proc AXIBAR_NUM_updated {IpView} {
  for { set i 0} {$i < 6} {incr i} {
    updateOf_AXIBAR_AS_$i $IpView
  }

  for { set i 0} {$i < 6} {incr i} {
      updateOf_AXIBAR_$i $IpView
      updateOf_AXIBAR_HIGHADDR_$i $IpView
      updateOf_AXIBAR2PCIEBAR_$i $IpView
  }
}



proc AXIBAR_AS_0_updated {IpView} {
      updateOf_AXIBAR_AS_1 $IpView
      updateOf_AXIBAR_1 $IpView
      updateOf_AXIBAR_HIGHADDR_1 $IpView
      updateOf_AXIBAR2PCIEBAR_1 $IpView
}
proc AXIBAR_AS_1_updated {IpView} {
      updateOf_AXIBAR_AS_2 $IpView
      updateOf_AXIBAR_2 $IpView
      updateOf_AXIBAR_HIGHADDR_2 $IpView
      updateOf_AXIBAR2PCIEBAR_2 $IpView
}
proc AXIBAR_AS_2_updated {IpView} {
      updateOf_AXIBAR_AS_3 $IpView
      updateOf_AXIBAR_3 $IpView
      updateOf_AXIBAR_HIGHADDR_3 $IpView
      updateOf_AXIBAR2PCIEBAR_3 $IpView
}
proc AXIBAR_AS_3_updated {IpView} {
      updateOf_AXIBAR_AS_4 $IpView
      updateOf_AXIBAR_4 $IpView
      updateOf_AXIBAR_HIGHADDR_4 $IpView
      updateOf_AXIBAR2PCIEBAR_4 $IpView
}
proc AXIBAR_AS_4_updated {IpView} {
      updateOf_AXIBAR_AS_5 $IpView
      updateOf_AXIBAR_5 $IpView
      updateOf_AXIBAR_HIGHADDR_5 $IpView
      updateOf_AXIBAR2PCIEBAR_5 $IpView
}

foreach param3 {AXIBAR_AS AXIBAR AXIBAR_HIGHADDR AXIBAR2PCIEBAR} {
  EvalSubstituting {param3} {
  proc updateOf_$param3_0 {IpView} {
    if { [get_param_value AXIBAR_NUM] > 0 } {
      set_property enabled true [ipgui::get_paramspec -name $param3_0 -of $IpView]
    } else {
      set_property enabled false [ipgui::get_paramspec -name $param3_0 -of $IpView]
    }
  }
  } 0
}


for {set i 1 } { $i< 6 } {incr i} {
    set j [expr $i+1]
 #   set k [expr $i-1]
    
      set paramList {AXIBAR_AS AXIBAR AXIBAR_HIGHADDR AXIBAR2PCIEBAR}
      foreach param4 $paramList {
        EvalSubstituting { i j param4} {
        proc updateOf_$param4_$i {IpView} {
          if { $i < [get_param_value AXIBAR_NUM] } {
            set_property enabled true [ipgui::get_paramspec -name $param4_$i -of $IpView]
          } else {
            set_property enabled false [ipgui::get_paramspec -name $param4_$i -of $IpView]
          }
        }
      } 0
    } 
}


for { set i 0} {$i < 6} {incr i} {
	set AXIBAR AXIBAR_${i}
	set AXI_HIGHADDR AXIBAR_HIGHADDR_${i}
	set AXI2PCIEBAR AXIBAR2PCIEBAR_${i}
	EvalSubstituting { i AXIBAR AXI_HIGHADDR AXI2PCIEBAR } {	
		
		proc updateModel_C_AXIBAR2PCIEBAR_$i { IpView } {
			set_property modelparam_value  [get_param_value  AXIBAR2PCIEBAR_$i	]  [ipgui::get_modelparamspec C_AXIBAR2PCIEBAR_$i -of $IpView]
		}
	
#    if { $i != 5 } {
      proc updateModel_C_AXIBAR_AS_$i { IpView } {
        if { [get_param_value  AXIBAR_AS_$i	]==false} {
          set val 0
        } else {
          set val 1
        }
        set_property modelparam_value $val   [ipgui::get_modelparamspec C_AXIBAR_AS_$i -of $IpView]
      }
 #   }
		
		proc updateModel_C_AXIBAR_$i { IpView } {
			set_property modelparam_value  [get_param_value  AXIBAR_$i	]  [ipgui::get_modelparamspec C_AXIBAR_$i -of $IpView]
		}
		
		proc updateModel_C_AXIBAR_HIGHADDR_$i { IpView } {
			set_property modelparam_value  [get_param_value  AXIBAR_HIGHADDR_$i	]  [ipgui::get_modelparamspec C_AXIBAR_HIGHADDR_$i -of $IpView]
		}
		
		proc validate_$AXIBAR {IpView} {
			return [RangeCheck4HexDec $AXIBAR 0 FFFFFFFF $IpView]
		}
		
		proc validate_$AXI_HIGHADDR {IpView} {
			return [RangeCheck4HexDec $AXI_HIGHADDR 0 FFFFFFFF $IpView]
		}
		
		proc validate_$AXI2PCIEBAR {IpView} {
		   if { [get_param_value AXIBAR_AS_$i] } {
			return [RangeCheck4HexDec $AXI2PCIEBAR 0 FFFFFFFFFFFFFFFF $IpView]
		   } else {
			return [RangeCheck4HexDec $AXI2PCIEBAR 0 FFFFFFFF $IpView]
			}
		}
	} 0

}


for { set i 0} {$i < 3} {incr i} {
	set Bar_Enabled BAR${i}_ENABLED
	set k [expr "$i - 1" ]
	set next [expr "$i+1" ]
	set Bar_Type BAR${i}_TYPE
	set Bar_Scale BAR${i}_SCALE
	set Bar_Size BAR${i}_SIZE
	set PCIEBAR2AXIBAR PCIEBAR2AXIBAR_${i}
        set device_port_type INCLUDE_RC
        set Bar_64bit BAR_64BIT

	EvalSubstituting { i k next Bar_Enabled Bar_Type Bar_Scale  Bar_Size PCIEBAR2AXIBAR device_port_type Bar_64bit} {	
		
		proc BAR$i_ENABLED_updated {IpView} {
			set Enabled_Bar [get_param_value   $Bar_Enabled  ]	
			updateOf$Bar_Type $IpView	 	
			if {$Enabled_Bar=="true"} {
				set_property enabled $Enabled_Bar [ipgui::get_paramspec $PCIEBAR2AXIBAR -of $IpView] 				
				set_property enabled true [ipgui::get_paramspec $Bar_Type -of $IpView]			
			} else {
				set_property enabled $Enabled_Bar [ipgui::get_paramspec $Bar_Type -of $IpView]
				set_property enabled false [ipgui::get_paramspec $PCIEBAR2AXIBAR -of $IpView]
			}			
			updateOf$Bar_Size $IpView
			updateOf$Bar_Scale $IpView
		}
		
		proc updateOf$Bar_Type {IpView} {
			set Enabled_Bar [get_param_value   $Bar_Enabled  ]		
			if {$Enabled_Bar=="true"} {								
				set_property range_value "Memory,Memory" [ipgui::get_paramspec $Bar_Type -of $IpView]
				set_property enabled true [ipgui::get_paramspec $Bar_Type -of $IpView]											
			} else {				
				set_property enabled $Enabled_Bar [ipgui::get_paramspec $Bar_Type -of $IpView]
				set_property range_value "N/A,N/A" [ipgui::get_paramspec $Bar_Type -of $IpView]
			}				
		}
		
		proc $Bar_Scale_updated {IpView} {
			updateOf$Bar_Size $IpView
		}
		
		proc $Bar_Type_updated {IpView} {
			updateOf$Bar_Size $IpView
		}
  
		
		proc updateOf$Bar_Scale {IpView} {
			set Enabled_Bar [get_param_value   $Bar_Enabled  ]	
			if {$Enabled_Bar=="true"} {								
				set_property enabled true [ipgui::get_paramspec $Bar_Scale -of $IpView]	
				set_property range_value "Kilobytes,Kilobytes,Megabytes,Gigabytes" [ipgui::get_paramspec $Bar_Scale -of $IpView]
			} else {				
				set_property enabled $Enabled_Bar [ipgui::get_paramspec $Bar_Scale -of $IpView]
				set_property range_value "N/A,N/A" [ipgui::get_paramspec $Bar_Scale -of $IpView]
			}	
		}
		proc updateOf$Bar_Size {IpView} {
			set Enabled_Bar [get_param_value   $Bar_Enabled  ]	
			set valueBar_Type [get_param_value   $Bar_Type  ]	
			set valueBar_Scale [get_param_value   $Bar_Scale  ]	
                        set device_type  [get_param_value $device_port_type ]
                        set 64bit_enabled [get_param_value $Bar_64bit]
			if {$valueBar_Type == "Memory" && $valueBar_Scale!="N/A"} {
                           if {$device_type eq "Root_Port_of_PCI_Express_Root_Complex" && $64bit_enabled == "true" } { 
                              switch $valueBar_Scale {
					Kilobytes {set list 16,8,16,32,64,128,256,512}
					Megabytes {set list 1,1,2,4,8,16,32,64,128,256,512}
					Gigabytes {set list 1,1,2,4}
			      }
                           } else {
				switch $valueBar_Scale {
					Kilobytes {set list 16,8,16,32,64,128,256,512}
					Megabytes {set list 1,1,2,4,8,16,32,64,128,256,512}
					Gigabytes {set list 1,1,2}
				}
                           }
				set_property range_value $list [ipgui::get_paramspec $Bar_Size -of $IpView]
				
			} else {			
				# set_property range_value "N/A,N/A" [ipgui::get_paramspec $Bar_Size -of $IpView]
				set_property range_value "8,8" [ipgui::get_paramspec $Bar_Size -of $IpView]
			}
			if {$Enabled_Bar=="true"} {								
				set_property enabled true [ipgui::get_paramspec $Bar_Size -of $IpView]
			} else {				
				set_property enabled $Enabled_Bar [ipgui::get_paramspec $Bar_Size -of $IpView]
				# set_property range_value "N/A,N/A" [ipgui::get_paramspec $Bar_Size -of $IpView]
				set_property range_value "8,8" [ipgui::get_paramspec $Bar_Size -of $IpView]
			}			
		}
		
		proc updateModel_C_PCIEBAR_LEN_$i {IpView} {
			set val [calulclateC_PCIEBAR_LEN $i $IpView]
			set_property modelparam_value $val [ipgui::get_modelparamspec -name C_PCIEBAR_LEN_$i -of $IpView]
		}
		
		proc validate_$PCIEBAR2AXIBAR {IpView} {
			return [RangeCheck4HexDec $PCIEBAR2AXIBAR 0 FFFFFFFF $IpView] 
#		   if { [get_param_value BAR_64BIT] } {
#			return [RangeCheck4HexDec $PCIEBAR2AXIBAR 0 FFFFFFFFFFFFFFFF $IpView]
#		   } else {
#			return [RangeCheck4HexDec $PCIEBAR2AXIBAR 0 FFFFFFFF $IpView] }
		}
		
	} 0
}

                proc updateOf_PCIEBAR2AXIBAR_0 {IpView} { 
                     set device_type  [get_param_value INCLUDE_RC ]
                     set 64bit_enabled [get_param_value BAR_64BIT]
                     set bar0_size [get_param_value BAR0_SIZE]
                     set bar0_scale [get_param_value BAR0_SCALE]

                     if {$device_type eq "Root_Port_of_PCI_Express_Root_Complex" && $64bit_enabled == "true" && $bar0_size == 4 && $bar0_scale == "Gigabytes"} { 
                        set_property enabled false [ipgui::get_paramspec PCIEBAR2AXIBAR_0 -of $IpView] 
                     } else { 
                        set_property enabled true [ipgui::get_paramspec PCIEBAR2AXIBAR_0 -of $IpView] 
                     }
}

proc BAR_64BIT_updated {IpView}  {
     updateOf_PCIEBAR2AXIBAR_0 $IpView
     updateOfBAR0_SIZE $IpView
}

proc BAR0_SIZE_updated {IpView} {
     updateOf_PCIEBAR2AXIBAR_0 $IpView
}

proc BAR0_Scale_updated {IpView} { 
     updateOf_PCIEBAR2AXIBAR_0 $IpView
}

proc calulclateC_PCIEBAR_LEN {num IpView} {
	set enabledBar [get_param_value BAR${num}_ENABLED]
	set scalevlaue [get_param_value BAR${num}_SCALE]
	set sizevlaue [get_param_value BAR${num}_SIZE]
	if {$enabledBar == "false"} {
		return 16
	} else {
		switch $sizevlaue {
			1 {
				switch $scalevlaue {
					Megabytes {return 20}
					Gigabytes {return 30}
				}
			}
			
			2 {
				switch $scalevlaue {
					Megabytes {return 21}
					Gigabytes {return 31}
				}
			}
			
			4 {
				switch $scalevlaue {
					Megabytes {return 22}
					Gigabytes {return 32}
				}
			}
			
			8 {
				switch $scalevlaue {
					Kilobytes {return 13}
					Megabytes {return 23}
				}
			}
			
			16 {
				switch $scalevlaue {
					Kilobytes {return 14}
					Megabytes {return 24}
				}
			}
			
			32 {
				switch $scalevlaue {
					Kilobytes {return 15}
					Megabytes {return 25}
				}
			}
			
			64 {
				switch $scalevlaue {
					Kilobytes {return 16}
					Megabytes {return 26}
				}
			}
			
			128 {
				switch $scalevlaue {
					Kilobytes {return 17}
					Megabytes {return 27}
				}
			}
			
			256 {
				switch $scalevlaue {
					Kilobytes {return 18}
					Megabytes {return 28}
				}
			}
			
			512 {
				switch $scalevlaue {
					Kilobytes {return 19}
					Megabytes {return 29}
				}
			}		
		}
	}
}

proc DT_Shared_Logic {IpView} {   
        if {([get_param_value shared_logic_in_core] eq "false") && ([get_param_value en_ext_clk] eq "false") && ([get_param_value en_ext_gt_common] eq "false")} {
            set    text "Core with no Shared Logic\n"        
            append text "- The CLOCKING and GT_COMMON used by this core are located in this IP core, and not available for sharing with other IP core\n"        
	    append text "- This option was also available with previous versions of the core\n\n\n"    
	} elseif {[get_param_value shared_logic_in_core] eq "true"} {        
            set    text "Core with internal CLOCKING and GT_COMMON\n"        
            append text "- The CLOCKING and GT_COMMON used by this IP core are located in this IP core, and are available for sharing with other IP cores\n"        
	    append text "- Please consult the product guide for information on the additional ports that are generated on this IP core to facilitate sharing\n\n\n"    
        } elseif {([get_param_value en_ext_clk] eq "true") && ([get_param_value en_ext_gt_common] eq "true")} { 
            set    text "Core with external CLOCKING and GT_COMMON\n"        
            append text "- The CLOCKING and GT_COMMON used by this core are located in its Example Design,\n" 
            append text "  and are available for sharing with other IP cores\n\n\n"        
        } elseif {[get_param_value en_ext_clk] eq "true"} {
            set    text "Core with external CLOCKING and internal GT_COMMON\n"        
            append text "- CLOCKING used by this core is located in its Example Design and is available for sharing with other IP cores\n"        
            append text "- GT_COMMON is internal and not available to share\n"        
#append text "- This option was also available with previous versions of the core\n\n\n"        
	} elseif {[get_param_value en_ext_gt_common] eq "true" } {
            set    text "Core with external GT_COMMON and internal CLOCKING\n"        
            append text "- GT_COMMON used by this  core is located in its Example Design and are available for sharing with other IP cores\n"        
            append text "- CLOCKING is internal and not available to share\n\n\n"
	} else {        
            set    text "Core with external CLOCKING and internal GT_COMMON\n"        
            append text "- CLOCKING used by this  core is located in its Example Design and is available for sharing with other IP cores\n"        
            append text "- GT_COMMON is internal and not available to share\n"        
	} 
	return $text 
}

proc updateOf_shared_logic_in_core {IpView} {

		if { [get_param_value PCIE_USE_MODE] == "IES" } {
			set_property enabled false [ipgui::get_paramspec shared_logic_in_core -of $IpView]  
		}  else { 
			if {[get_param_value en_ext_clk] eq "true"} { 
				set_property enabled false [ipgui::get_paramspec shared_logic_in_core -of $IpView]  
			} elseif {[get_param_value en_ext_gt_common] eq "true"} {
				set_property enabled false [ipgui::get_paramspec shared_logic_in_core -of $IpView]  
			} else {
				set_property enabled true [ipgui::get_paramspec shared_logic_in_core -of $IpView]  
			}
		}
}
proc updateOf_en_ext_pipe_interface {IpView} { 
 if {[get_param_value en_ext_clk] eq "true"} { 
     set_property enabled true [ipgui::get_paramspec en_ext_pipe_interface -of $IpView]
  } else {
    set_property enabled false [ipgui::get_paramspec en_ext_pipe_interface -of $IpView]
    set_property value false [ipgui::get_paramspec en_ext_pipe_interface -of $IpView]
  }
}

proc updateOf_en_ext_clk {IpView} {

		if { [get_param_value PCIE_USE_MODE] == "IES" } {
			set_property enabled false [ipgui::get_paramspec en_ext_clk -of $IpView]  
		}  else {
			if {[get_param_value shared_logic_in_core] eq "true"} { 
				set_property enabled false [ipgui::get_paramspec en_ext_clk -of $IpView]
			} else {
				set_property enabled true [ipgui::get_paramspec en_ext_clk -of $IpView]
			}
		}
}

proc updateOf_en_ext_gt_common {IpView} {

		if { [get_param_value PCIE_USE_MODE] == "IES" } {
			set_property enabled false [ipgui::get_paramspec en_ext_gt_common -of $IpView]  
		}  else {
			if {[get_param_value shared_logic_in_core] eq "true"} { 
				set_property enabled false [ipgui::get_paramspec en_ext_gt_common -of $IpView]
			} else {
				set_property enabled true [ipgui::get_paramspec en_ext_gt_common -of $IpView]
			}
		}
}

proc shared_logic_in_core_updated {IpView} { 
        if {([get_param_value shared_logic_in_core] eq "false") && ([get_param_value en_ext_clk] eq "false") && ([get_param_value en_ext_gt_common] eq "false")} {
		set_property load_image "xgui/No_Shared_Logic.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
        } elseif {[get_param_value shared_logic_in_core] eq "true"} {
		set_property load_image "xgui/Shared_Logic_In_Core.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	}
     updateOf_en_ext_clk $IpView 
     updateOf_en_ext_gt_common $IpView 
}

proc en_ext_clk_updated {IpView} { 
        if {([get_param_value shared_logic_in_core] eq "false") && ([get_param_value en_ext_clk] eq "false") && ([get_param_value en_ext_gt_common] eq "false")} {
		set_property load_image "xgui/No_Shared_Logic.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	} elseif {([get_param_value en_ext_clk] eq "true") && ([get_param_value en_ext_gt_common] eq "true")} { 
		set_property load_image "xgui/Ext_Clk_Ext_GT_common.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	} elseif {([get_param_value en_ext_clk] eq "false") && ([get_param_value en_ext_gt_common] eq "true")} { 
		set_property load_image "xgui/Ext_GT_Common_Mode.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	} elseif {([get_param_value en_ext_clk] eq "true") && ([get_param_value en_ext_gt_common] eq "false")} { 
		set_property load_image "xgui/Ext_Clock_Mode.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
        } elseif {[get_param_value en_ext_clk] eq "true"} {
		set_property load_image "xgui/Ext_Clock_Mode.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	}
     updateOf_shared_logic_in_core $IpView
     updateOf_en_ext_gt_common $IpView 
     updateOf_en_ext_pipe_interface $IpView
}

proc en_ext_gt_common_updated {IpView} {
        if {([get_param_value shared_logic_in_core] eq "false") && ([get_param_value en_ext_clk] eq "false") && ([get_param_value en_ext_gt_common] eq "false")} {
		set_property load_image "xgui/No_Shared_Logic.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
        } elseif {([get_param_value en_ext_clk] eq "true") && ([get_param_value en_ext_gt_common] eq "true")} { 
		set_property load_image "xgui/Ext_Clk_Ext_GT_common.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	} elseif {([get_param_value en_ext_clk] eq "false") && ([get_param_value en_ext_gt_common] eq "true")} { 
		set_property load_image "xgui/Ext_GT_Common_Mode.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	} elseif {([get_param_value en_ext_clk] eq "true") && ([get_param_value en_ext_gt_common] eq "false")} { 
		set_property load_image "xgui/Ext_Clock_Mode.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	} elseif {[get_param_value en_ext_gt_common] eq "true"} {
		set_property load_image "xgui/Ext_GT_Common_Mode.png" [ipgui::get_imagespec PixmapAFix2 -of $IpView]     
	}
     updateOf_en_ext_clk $IpView 
     updateOf_shared_logic_in_core $IpView
}

proc updateModel_C_INCLUDE_RC {IpView} {
	if {[get_param_value INCLUDE_RC]!= "PCI_Express_Endpoint_device"} {
		set val 1
	} else {
		set val 0
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_INCLUDE_RC -of $IpView]
}

proc updateModel_C_PCIEBAR_AS {IpView} {
	if {[get_param_value BAR_64BIT] == "true"} {
		set val 1
	} else {
		set val 0
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_PCIEBAR_AS -of $IpView]
}

proc updateModel_C_PCIE_CAP_SLOT_IMPLEMENTED {IpView} {
	if {[get_param_value INCLUDE_RC] == "PCI_Express_Endpoint_device"} {
		set val 0
	} else {
		if {[get_param_value SLOT_CLOCK_CONFIG] == "true"} {
			set val 1
		} else {
			set val 0
		}
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_PCIE_CAP_SLOT_IMPLEMENTED -of $IpView]
}

proc updateModel_C_SLOT_CLOCK_CONFIG {IpView} {
	if {[get_param_value SLOT_CLOCK_CONFIG] == "true"} {
		set val TRUE
	} else {
		set val FALSE
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_SLOT_CLOCK_CONFIG -of $IpView]
}


proc updateModel_C_S_AXI_SUPPORTS_NARROW_BURST  {IpView} {
	if {[get_param_value S_AXI_SUPPORTS_NARROW_BURST]!= "false"} {
		set val 1
	} else {
		set val 0
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_S_AXI_SUPPORTS_NARROW_BURST  -of $IpView]
}

proc updateModel_C_INCLUDE_BAROFFSET_REG   {IpView} {
	if {[get_param_value INCLUDE_BAROFFSET_REG ]!= "false"} {
		set val 1
	} else {
		set val 0
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_INCLUDE_BAROFFSET_REG   -of $IpView]
}

proc updateModel_C_INTERRUPT_PIN   {IpView} {
	if {[get_param_value INTERRUPT_PIN ]!= "false"} {
		set val 1
	} else {
		set val 0
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_INTERRUPT_PIN   -of $IpView]
}


proc updateModel_C_COMP_TIMEOUT   {IpView} {
	if {[get_param_value COMP_TIMEOUT ]== "50us"} {
		set val 0
	} else {
		set val 1
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_COMP_TIMEOUT   -of $IpView]
}


proc updateModel_C_PCIE_USE_MODE {IpView} {
   set fmly [string toupper [getDeviceFamily]]
   set device [string toupper [getDevice]]
	if {[get_param_value PCIE_USE_MODE]== "IES"} {
            if {($fmly == "KINTEX7") || ($fmly == "VIRTEX7") || ($fmly == "ZYNQ") } {
			set val "1.1"
		} else {
			set val "1.0"
		}
	} else {
		if {($fmly=="ARTIX7") || ($fmly == "ZYNQ" && ($device == "XC7Z015" || $device == "XC7Z015I"))} { 
			set val "1.0"
		} else {
			set val "3.0"
		}
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_PCIE_USE_MODE -of $IpView]
}


proc updateModel_SHARED_LOGIC_IN_CORE {IpView} {
	set_property modelparam_value [string toupper [expr {([get_param_value   shared_logic_in_core  ]== true)?true:false}]] [ipgui::get_modelparamspec SHARED_LOGIC_IN_CORE -of $IpView]
}

proc updateModel_PCIE_EXT_CLK {IpView} {
	set_property modelparam_value [string toupper [expr {([get_param_value   en_ext_clk  ]== true)?true:false}]] [ipgui::get_modelparamspec PCIE_EXT_CLK -of $IpView]
}

proc updateModel_PCIE_EXT_GT_COMMON {IpView} {
	set_property modelparam_value [string toupper [expr {([get_param_value   en_ext_gt_common  ]== true)?true:false}]] [ipgui::get_modelparamspec PCIE_EXT_GT_COMMON -of $IpView]
}


proc updateModel_C_REF_CLK_FREQ {IpView} {
	if {[get_param_value REF_CLK_FREQ]== "100_MHz"} {
		set val 0
	} elseif {[get_param_value REF_CLK_FREQ]== "125_MHz"} {
		set val 1
	} else {
		set val 2
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_REF_CLK_FREQ -of $IpView]
}


proc updateModel_C_NO_OF_LANES {IpView} {
	set_property modelparam_value [string map {X ""} [get_param_value NO_OF_LANES]] [ipgui::get_modelparamspec -name C_NO_OF_LANES -of $IpView]
}


proc updateModel_C_MAX_LINK_SPEED {IpView} {
	if {[get_param_value MAX_LINK_SPEED]!= "2.5_GT/s"} {
		set val 1
	} else {
		set val 0
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name C_MAX_LINK_SPEED -of $IpView]
}


foreach {param model_param} {Component_Name C_INSTANCE  VENDOR_ID C_VENDOR_ID REV_ID  C_REV_ID DEVICE_ID C_DEVICE_ID \
		M_AXI_DATA_WIDTH C_M_AXI_DATA_WIDTH  SUBSYSTEM_VENDOR_ID C_SUBSYSTEM_VENDOR_ID SUBSYSTEM_ID C_SUBSYSTEM_ID \		
	} {
	EvalSubstituting {param model_param } {
	proc updateModel_$model_param { IpView } {
		set_property modelparam_value  [get_param_value  $param	]  [ipgui::get_modelparamspec $model_param -of $IpView]
	}
	} 0
}

foreach {param model_param} {M_AXI_ADDR_WIDTH C_M_AXI_ADDR_WIDTH S_AXI_DATA_WIDTH C_S_AXI_DATA_WIDTH S_AXI_ADDR_WIDTH C_S_AXI_ADDR_WIDTH \
		S_AXI_ID_WIDTH C_S_AXI_ID_WIDTH HIGHADDR C_HIGHADDR BASEADDR C_BASEADDR NUM_MSI_REQ C_NUM_MSI_REQ PCIEBAR2AXIBAR_0 \
		C_PCIEBAR2AXIBAR_0 PCIEBAR2AXIBAR_1 C_PCIEBAR2AXIBAR_1 PCIEBAR2AXIBAR_2 C_PCIEBAR2AXIBAR_2 PCIEBAR2AXIBAR_0_SEC \
		C_PCIEBAR2AXIBAR_0_SEC PCIEBAR2AXIBAR_1_SEC C_PCIEBAR2AXIBAR_1_SEC PCIEBAR2AXIBAR_2_SEC C_PCIEBAR2AXIBAR_2_SEC \
		CLASS_CODE C_CLASS_CODE} {
	EvalSubstituting {param model_param } {
	proc updateModel_$model_param { IpView } {
		set_property modelparam_value  [get_param_value  $param	]  [ipgui::get_modelparamspec $model_param -of $IpView]
	}
	} 0
}

proc updateModel_C_MSI_DECODE_ENABLE {IpView} { 
	set_property modelparam_value [string toupper [expr {([get_param_value MSI_DECODE_ENABLED]== true)?true:false}]] [ipgui::get_modelparamspec -name C_MSI_DECODE_ENABLE -of $IpView]
}

proc updateModel_C_AXIBAR_NUM {IpView} {
	set_property modelparam_value  [get_param_value AXIBAR_NUM] [ipgui::get_modelparamspec C_AXIBAR_NUM -of $IpView]
}

proc updateModel_C_PCIEBAR_NUM {IpView} {
	set val 0
	for {set i 0} {$i<=2} {incr i} {
		if {[get_param_value  BAR${i}_ENABLED] == "true"} {
			incr val
		}	
	}
	set_property modelparam_value  $val [ipgui::get_modelparamspec C_PCIEBAR_NUM -of $IpView]
}

proc updateModel_C_PCIE_BLK_LOCN {IpView} {
 switch [get_param_value PCIE_BLK_LOCN ] {
      "X0Y0" {
         set C_PCIE_BLK_LOCN 0
      }
      "X0Y1" {
         set C_PCIE_BLK_LOCN 1
      }
      "X0Y2" {
         set C_PCIE_BLK_LOCN 2
      }
      "X1Y0" {
         set C_PCIE_BLK_LOCN 3
      }
      "X1Y1" {
         set C_PCIE_BLK_LOCN 4
      }
      
   }
 set_property modelparam_value $C_PCIE_BLK_LOCN [ipgui::get_modelparamspec C_PCIE_BLK_LOCN -of $IpView] 
} 

proc updateModel_C_XLNX_REF_BOARD {IpView} {
	switch [get_param_value   XLNX_REF_BOARD  ] {
		"None" {
			set C_XLNX_REF_BOARD   "NONE"
		}
		"KC705_REVA" {
			set C_XLNX_REF_BOARD   "KC705_REVA"
		}
		"KC705_REVB" {
			set C_XLNX_REF_BOARD   "KC705_REVB"
		}
		"KC705_REVC" {
			set C_XLNX_REF_BOARD   "KC705_REVC"
		}
		"VC707" {
			set C_XLNX_REF_BOARD   "VC707"
		}
		"ZC706" {
			set C_XLNX_REF_BOARD   "ZC706"
		}
		"AC701" {
			set C_XLNX_REF_BOARD   "AC701"
		}
	}
		set_property modelparam_value $C_XLNX_REF_BOARD [ipgui::get_modelparamspec C_XLNX_REF_BOARD -of $IpView]  
}

proc init_xpg_bd {IpView} {
  foreach i {0 1 2 3 4 5} {
		EvalSubstituting { i } {
      set_property visible false [ipgui::get_paramspec -name AXIBAR_$i -of $IpView]
      set_property visible false [ipgui::get_paramspec -name AXIBAR_HIGHADDR_$i -of $IpView]
    } 0
  }
  set_property visible false [ipgui::get_groupspec -name "AXI Addressing" -of $IpView]
}

proc updateModel_EXT_CH_GT_DRP {IpView} {
  if { [get_param_value en_ext_ch_gt_drp] } {
    set val "TRUE"
  } else {
    set val "FALSE"
  }
  set_property modelparam_value $val [ipgui::get_modelparamspec -name EXT_CH_GT_DRP -of $IpView]
}

proc updateModel_TRANSCEIVER_CTRL_STATUS_PORTS {IpView} {
	if { [get_param_value en_transceiver_status_ports] } {
		set val "TRUE"
	} else {
		set val "FALSE"
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name TRANSCEIVER_CTRL_STATUS_PORTS -of $IpView]
}

proc updateModel_EXT_PIPE_INTERFACE {IpView} {
	if { [get_param_value en_ext_pipe_interface] } {
		set val "TRUE"
	} else {
		set val "FALSE"
	}
	set_property modelparam_value $val [ipgui::get_modelparamspec -name EXT_PIPE_INTERFACE -of $IpView]
}

proc updateModel_C_SPEED {IpView} { 
 set c_xspeedgrade [getSpeedGrade]

 set_property modelparam_value [string tolower "$c_xspeedgrade"] [ipgui::get_modelparamspec -name C_SPEED -of $IpView]
}

proc updateModel_AXI_ACLK_LOOPBACK {IpView} { 
	set_property modelparam_value [string toupper [expr {([get_param_value axi_aclk_loopback ]== true)?true:false}]] [ipgui::get_modelparamspec -name AXI_ACLK_LOOPBACK -of $IpView]
}

proc updateModel_NO_SLV_ERR {IpView} { 
	set_property modelparam_value [string toupper [expr {([get_param_value no_slv_err]== true)?true:false}]] [ipgui::get_modelparamspec -name NO_SLV_ERR -of $IpView]
}

proc updateModel_C_RP_BAR_HIDE {IpView} { 
	set_property modelparam_value [string toupper [expr {([get_param_value rp_bar_hide]== true)?true:false}]] [ipgui::get_modelparamspec -name C_RP_BAR_HIDE -of $IpView]
}
