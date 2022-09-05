# These are the values from your environment that variables.pkr.hcl will use
vcenter_username = ""
vcenter_password = ""

# vCenter details
vcenter_server        = ""
vcenter_sslconnection = true
vcenter_datacenter    = ""
vcenter_host          = ""
vcenter_datastore     = ""
vcenter_folder        = ""

# VM Hardware Configuration
vm_os_type          = "windows9Server64Guest"
vm_firmware         = "efi"
vm_hardware_version = 17
vm_cpu_sockets      = 2
vm_cpu_cores        = 1
vm_ram              = 4096
vm_nic_type         = "vmxnet3"
vm_network          = "LAN"
vm_disk_controller  = ["pvscsi"]
vm_disk_size        = 20480
vm_disk_thin        = true
config_parameters = {
  "devices.hotplug"                         = "FALSE",
  "guestInfo.svga.wddm.modeset"             = "FALSE",
  "guestInfo.svga.wddm.modesetCCD"          = "FALSE",
  "guestInfo.svga.wddm.modesetLegacySingle" = "FALSE",
  "guestInfo.svga.wddm.modesetLegacyMulti"  = "FALSE"
}

# Removable Media Configuration
vcenter_iso_datastore = ""
os_iso_path           = ""
os_iso_file           = ""
vmtools_iso_path      = ""
vmtools_iso_file      = ""
vm_cdrom_remove       = true

# Build
vm_convert_template = true
winrm_username = "Administrator"
winrm_password = "Should be same as the password in the autounattend.xml"

# Provisioner Settings
powershell_scripts = [
  "./scripts/postSetup.ps1"
]
