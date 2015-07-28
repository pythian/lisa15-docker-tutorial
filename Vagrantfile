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
    i.vm.box = "dockertutorial"
    # i.vm.network :public_network, :dev => "em1", :mode => "bridge"
    i.vm.hostname = "dockertutorial-01"
    i.vm.provider :libvirt do |domain, override|
      # Remember to run with --provider=libvirt otherwise Vagrant will execute also the virtualbox section!
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
      domain.driver = "kvm"
      #domain.host = "atreas.lan"
      domain.storage_pool_name = "default"
      domain.memory = 1024
      domain.cpus = 2
      domain.management_network_name = "vagrant"
      domain.management_network_address = "192.168.123.0/24"
    end
    i.vm.provider :virtualbox do |v, override|
      # Use virtualbox synced folders, should work in all operating systems
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', create: true
      v.memory = 1024
      v.cpus = 2
    end
    i.vm.provider :vmware_fusion do |v, override|
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
      v.vmx["memsize"] = 1024
      v.vmx["numvcpus"] = 2
    end
    i.vm.network :private_network, ip: "192.168.123.140"

    i.vm.provision "shell",
      inline: "ansible-playbook /tmp/vagrantupansible/playbooks/dockertutorialenv-01.yml"
  end


  config.vm.define "dockertutorial-02", autostart: true do |i|
    i.vm.box = "dockertutorial"
    i.vm.hostname = "dockertutorial-02"
    i.vm.provider :libvirt do |domain, override|
      # Remember to run with --provider=libvirt otherwise Vagrant will execute also the virtualbox section!
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
      domain.driver = "kvm"
      domain.storage_pool_name = "default"
      domain.memory = 512
      domain.cpus = 1
      domain.management_network_name = "vagrant"
      domain.management_network_address = "192.168.123.0/24"
    end
    i.vm.provider :virtualbox do |v, override|
      # Use virtualbox synced folders, should work in all operating systems
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', create: true
      v.memory = 512
      v.cpus = 1
    end
    i.vm.provider :vmware_fusion do |v, override|
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
      v.vmx["memsize"] = 512
      v.vmx["numvcpus"] = 1
    end
    i.vm.network :private_network, ip: "192.168.123.141"

    i.vm.provision "shell",
      inline: "ansible-playbook /tmp/vagrantupansible/playbooks/dockertutorialenv-02.yml"
  end

  config.vm.define "dockertutorial-03", autostart: true do |i|
    i.vm.box = "dockertutorial"
    i.vm.hostname = "dockertutorial-03"
    i.vm.provider :libvirt do |domain, override|
      # Remember to run with --provider=libvirt otherwise Vagrant will execute also the virtualbox section!
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
      domain.driver = "kvm"
      domain.storage_pool_name = "default"
      domain.memory = 512
      domain.cpus = 1
      domain.management_network_name = "vagrant"
      domain.management_network_address = "192.168.123.0/24"
    end
    i.vm.provider :virtualbox do |v, override|
      # Use virtualbox synced folders, should work in all operating systems
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', create: true
      v.memory = 512
      v.cpus = 1
    end
    i.vm.provider :vmware_fusion do |v, override|
      override.vm.synced_folder '.', '/vagrant', disabled: true
      override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
      override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
      v.vmx["memsize"] = 512
      v.vmx["numvcpus"] = 1
    end
    i.vm.network :private_network, ip: "192.168.123.142"

    i.vm.provision "shell",
      inline: "ansible-playbook /tmp/vagrantupansible/playbooks/dockertutorialenv-03.yml"
    end
 
end
