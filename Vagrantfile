# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version '>= 1.6.0'

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

  # Resolve stdin: is not a tty in ubuntu over vagrant
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

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

      host_config.vm.provider :vmware_fusion do |vmwarefusion, override|
        override.vm.synced_folder '.', '/vagrant', disabled: true
        override.vm.synced_folder './ansible-local/','/tmp/vagrantupansible', type: 'rsync'
        override.vm.synced_folder './ansible_build_deploy/','/vagrant/ansible_build_deploy/', type: 'rsync', create: true
        vmwarefusion.vmx["memsize"] = params['memory']
        vmwarefusion.vmx["numvcpus"] = params['cpus']
        end
      
      host_config.vm.provision :shell, inline: "ansible-playbook /tmp/vagrantupansible/playbooks/#{host}.yml"

      if (/dockertutorial-01/ =~ host) != nil
        host_config.vm.provision :shell, inline: "ansible-playbook /vagrant/ansible_build_deploy/run_haproxy_via_consultemplate.yml"
      end
    end
  end
end
