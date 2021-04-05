terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "1.25.0"
    }
  }
}

provider "vsphere" {
  user = var.user
  vsphere_server = var.server
  password = var.password
  allow_unverified_ssl = true # if you have a self-signed cert
}

data "vsphere_datacenter" "dc" {
  name = "222"
}

data "vsphere_datastore" "datastore" {
  name          = "compelnt-ssd-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "Production/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "DDN-vlan-41"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  #name          = "centos8-template"
  name          = "CentOS7-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}
