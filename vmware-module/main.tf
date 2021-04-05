provider "vsphere" {
  user           = "vbrik"
  #password       = ""
  vsphere_server = "vulcan"
  allow_unverified_ssl = true # if you have a self-signed cert
}

# Deploy 2 linux VMs
module "example-server-linuxvm" {
  source    = "Terraform-VMWare-Modules/vm/vsphere"
  version   = "2.2.0"
  vmtemp    = "centos8-template"
  instances = 1
  vmname    = "tf-test"
  vmrp      = "vbrik"
  network = {
    "DDN-vlan-41" = ["10.128.108.241"]
  }
  ipv4submask = ["23"]
  vmgateway = "10.128.108.1"
  dc        = "222"
  datastore = "compelnt-ssd-1"
}
