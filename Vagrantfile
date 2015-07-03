# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

# Defaults for config options defined in CONFIG
$boxnames = { :libvirt => "baremettle/ubuntu-14.04" }
$num_instances = 1
$instance_name_prefix = "core"
$update_channel = "alpha"
$image_version = "current"
$enable_serial_logging = false
$share_home = false
$vm_gui = false
$vm_memory = 1024
$vm_cpus = 1
$shared_folders = {}
$forwarded_ports = {}

Vagrant.configure("2") do |config|
  config.vm.define "dockertutorial-01", autostart: true do |i|
    i.vm.box = "dockertutorial-01"
    i.vm.network :public_network, :dev => "em1", :mode => "bridge"
    i.vm.hostname = "dockertutorial-01"
    i.vm.synced_folder './ansible-local','/vagrant', type: 'rsync'
    i.vm.provider :libvirt do |domain|
      domain.driver = "kvm"
      #domain.host = "atreas.lan"
      domain.storage_pool_name = "default"
      domain.memory = 512
      domain.cpus = 1
      domain.management_network_name = "vagrant"
      domain.management_network_address = "192.168.123.0/24"
    end
    config.vm.network :private_network, ip: "192.168.123.140"

    config.vm.provision "shell",
      inline: "ansible-playbook /vagrant/playbooks/dockertutorialenv.yml"
  end

  config.vm.define "dockertutorial-02", autostart: true do |i|
    i.vm.box = "dockertutorial-02"
    i.vm.network :public_network, :dev => "em1", :mode => "bridge"
    i.vm.hostname = "dockertutorial-02"
    i.vm.synced_folder './','/vagrant', type: 'rsync'
    i.vm.provider :libvirt do |domain|
      domain.driver = "kvm"
      #domain.host = "atreas.lan"
      domain.storage_pool_name = "default"
      domain.memory = 512
      domain.cpus = 1
      domain.management_network_name = "vagrant"
      domain.management_network_address = "192.168.123.0/24"
    end
    config.vm.network :private_network, ip: "192.168.123.141"
  end

 
end
