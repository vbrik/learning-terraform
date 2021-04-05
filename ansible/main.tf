resource "vsphere_virtual_machine" "vm" {
  name             = "tf-test"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory   = 8196
  guest_id = data.vsphere_virtual_machine.template.guest_id
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  
  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.template.disks.0.size
    unit_number = data.vsphere_virtual_machine.template.disks.0.unit_number
    eagerly_scrub    = false
    thin_provisioned = false
  }
  disk {
    label = "disk1"
    size  = data.vsphere_virtual_machine.template.disks.1.size
    unit_number = data.vsphere_virtual_machine.template.disks.1.unit_number
    eagerly_scrub    = false
    thin_provisioned = false
  }
  disk {
    label = "disk2"
    size  = data.vsphere_virtual_machine.template.disks.2.size
    unit_number = data.vsphere_virtual_machine.template.disks.2.unit_number
    eagerly_scrub    = false
    thin_provisioned = false
  }
  disk {
    label = "disk3"
    size  = data.vsphere_virtual_machine.template.disks.3.size
    unit_number = data.vsphere_virtual_machine.template.disks.3.unit_number
    eagerly_scrub    = false
    thin_provisioned = false
  }
  disk {
    label = "disk4"
    size  = data.vsphere_virtual_machine.template.disks.4.size
    unit_number = data.vsphere_virtual_machine.template.disks.4.unit_number
    eagerly_scrub    = false
    thin_provisioned = false
  }

  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      dns_server_list = ["144.92.100.242", "144.92.100.240"]
      linux_options {
        host_name = "tf-test"
        domain    = "icecube.wisc.edu"
      }
      network_interface {
        ipv4_address = "10.128.108.241"
        ipv4_netmask = 23
      }
      ipv4_gateway = "10.128.108.1"
    }
  }
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]
    connection {
      type     = "ssh"
      user     = "root"
      host     = self.name
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.name}, nginx.yaml"
  }
}
