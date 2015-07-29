# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version '>= 1.6.0'

# Defaults for config options defined in CONFIG
$boxnames = { :libvirt => 'baremettle/ubuntu-14.04' }
$num_instances = 1
$instance_name_prefix = 'core'
$update_channel = 'alpha'
$image_version = 'current'
$enable_serial_logging = false
$share_home = false
$vm_gui = false
$vm_memory = 1024
$vm_cpus = 1
$shared_folders = {}
$forwarded_ports = {}

Vagrant.configure('2') do |config|
  hosts = {
    'dockertutorial-01' => {
      'address' => '192.168.123.140',
      'memory'  => 1024,
      'cpus'    => 2
    },
    'dockertutorial-02' => {
      'address' => '192.168.123.141',
      'memory'  => 512,
      'cpus'    => 1
    },
    'dockertutorial-03' => {
      'address' => '192.168.123.142',
      'memory'  => 512,
      'cpus'    => 1
    }
  }

  hosts.each do |host, params|
    config.vm.define host, autostart: true do |host_config|
      host_config.vm.box = 'dockertutorial'
      host_config.vm.hostname = "#{host}"
      host_config.vm.network :private_network, ip: params['address']

      host_config.vm.provider :libvirt do |libvirt, override|
        # Remember to run with --provider=libvirt otherwise Vagrant will execute also the virtualbox section!
        override.vm.synced_folder '.', '/vagrant', disabled: true
        override.vm.synced_folder './ansible-local/', '/tmp/vagrantupansible', type: 'rsync'
        override.vm.synced_folder './ansible_build_deploy/', '/vagrant/ansible_build_deploy/', type: 'rsync', create: true

        libvirt.driver = 'kvm'
        libvirt.storage_pool_name = 'default'
        libvirt.management_network_name = 'vagrant'
        libvirt.management_network_address = '192.168.123.0/24'
        libvirt.memory = params['memory']
        libvirt.cpus = params['cpus']
      end

      host_config.vm.provider :virtualbox do |virtualbox, override|
        # Use virtualbox synced folders, should work in all operating systems
        override.vm.synced_folder '.', '/vagrant', disabled: true
        override.vm.synced_folder './ansible-local/', '/tmp/vagrantupansible'
        override.vm.synced_folder './ansible_build_deploy/', '/vagrant/ansible_build_deploy/', create: true

        virtualbox.memory = params['memory']
        virtualbox.cpus = params['cpus']
      end

      host_config.vm.provision :shell do |s|
        s.inline = "ansible-playbook /tmp/vagrantupansible/playbooks/#{host}.yml"
      end
    end
  end
end
