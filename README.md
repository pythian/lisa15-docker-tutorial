# Docker tutorial packer and Vagrant templates

## Table of Contents

1. [Overview](#overview)
2. [Setting up the Tutorial Environment](#setting-up-the-tutorial-environment)
  * [Requirements](#requirements)
  * [Building the Vagrant Box](#building-the-vagrant-box)
    * [Providers](#providers)
    * [Adding a User](#adding-a-user)
  * [Adding the Box to Vagrant](#adding-the-box-to-vagrant)
  * [Provision the Virtual Machines With Vagrant](#provision-the-virtual-machines-with-vagrant)
3. [Performing Tutorial Tasks](#performing-tutorial-tasks)
  * [Build the ```helloweather``` Docker Image](#build-the-helloweather-docker-image)
  * [Launch an Instance of the Container](#launch-an-instance-of-the-container)
  * [Access the Application](#access-the-application)
  * [Review the HAProxy Configuration](#review-the-haproxy-configuration)
  * [Launch an Additional Container](#launch-an-additional-container)
4. [Preconfigured IP Addresses](#preconfigured-ip-addresses)
5. [Software Installed](#software-installed)
6. [VM Specific Software](#vm-specific-software)
7. [Acknowledgements](#acknowledgements)

## Overview

Blah blah

## Setting up the tutorial environment

### Requirements

1. Operating system: Linux, Mac OS X, Windows
2. [Vagrant](https://www.vagrantup.com/downloads.html): version >1.6.2
3. [Packer](https://www.packer.io/downloads.html): if you wish to build the Vagrant box yourself
4. Vagrant and Packer compatible virtualization tool. Choices include:
  * [VirtualBox](https://www.virtualbox.org/wiki/Downloads): works on each of the listed operating systems
  * [KVM](http://www.linux-kvm.org/page/Main_Page) + [libvirt](http://libvirt.org/): for Linux systems. Check installation instructions for your distribution. You will also need the [vagrant-libvirt](https://github.com/pradels/vagrant-libvirt#installation) plugin
  * [VMware Fusion](https://www.vagrantup.com/vmware): for Mac systems, also requires the Vagrant [VMware](https://www.vagrantup.com/vmware) plugin. Both of these must be purchased
4. Network bandwidth: If you do decide to build the box yourself, you can expect to have to download approximately 2.5GB of data
5. Disk space: for Libvirt you will need approx 6GB under ```~/.vagrant.d/boxes``` **and** the same under ```/var/lib/libvirt/images``` (this is due to vagrant-libvirt and how images are stored in libvirt). For the other hypervisors, you will need half of this space.

### Building the Vagrant box

#### Providers

##### Libvirt

```bash
packer build ubuntu14.04-dockertutorial-01.json
```

**IMPORTANT: Libvirt by default uses ```/tmp``` during image build operations. If your ```/tmp``` is <6GB please provide a directory with sufficient space in the ```TMPDIR``` environment variable**

```bash
export TMPDIR=/path/with/space; packer build ubuntu14.04-dockertutorial-01.json
```

##### VirtualBox:

```bash
packer build vbox-ubuntu14.04-dockertutorial-01.json
```

##### VMWare Fusion (Mac OS X):

```bash
packer build vmware-ubuntu14.04-dockertutorial-01.json
```

#### Adding a user

As an option if you want to create a new user e.g. ubuntu use:

```bash
read -p 'Enter password: ' -s password
packer build -var 'user=ubuntu' -var "password=$password" ubuntu14.04-dockertutorial-01.json
```

### Adding the box to Vagrant

Packer will build a box that you can find in the ```box/``` directory. Add it to your Vagrant environment using:

```bash
vagrant box add box/dockertutorial-01.box --name "dockertutorial"
```

### Provision the virtual machines with Vagrant

#### Libvirt:

First, ensure you have the vagrant-libvirt plugin installed (```vagrant install vagrant-libvirt```). Then run the following:

```bash
vagrant up --provider=libvirt --no-parallel
```

#### Virtualbox:

Run:

```bash
vagrant up --provider=virtualbox --no-parallel
```

#### VMWare Fusion:

Ensure you have purchased and installed the VMware Fusion Vagrant plugin installed.
Run:

```bash
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
vagrant up --no-parallel
```

## Performing tutorial tasks

### Build the ```helloweather``` Docker image:

First, SSH to dockertutorial-01:

```bash
vagrant ssh dockertutorial-01
```

Then change to the ```/vagrant``` directory and build the image:

```bash
vagrant@dockertutorial-01:~$ cd /vagrant
vagrant@dockertutorial-01:/vagrant$ ansible-playbook ansible_build_deploy/build_helloweather.yml
```

### Launch an instance of the container

```bash
vagrant@dockertutorial-01:/vagrant$ ansible-playbook ansible_build_deploy/deploy_helloweather.yml
```

This will deploy the ```helloweather``` application on the second virtual machine, ```dockertutorial-02```, by default.

### Access the application

Visit <http://192.168.123.140:10000> to access the application via the HAProxy load balancer.

### Review the HAProxy configuration

All ```helloweather``` containers automatically get added to the list of HAProxy backends via consul-template. Review the HAProxy configuration which can be found in ```/etc/haproxy/haproxy.cfg```

### Launch an additional container

```bash
vagrant@dockertutorial-01:/vagrant$ ansible-playbook ansible_build_deploy/deploy_helloweather.yml
```

#### Optional: Specify the Shipyard engine (Docker host) you wish to deploy the container to

You may explicitly specify the Shipyard engine (Docker host) you wish your container to land on by overriding the variable ```target_shipyard_engine```. For example, to deploy the ```helloweather``` application to ```dockertutorial-03```, you'd run:

```bash
vagrant@dockertutorial-01:/vagrant$ ansible-playbook ansible_build_deploy/deploy_helloweather.yml -e "target_shipyard_engine=dockertutorial-03"
```

## Preconfigured IP addresses:

| Vagrant VM name   |      IP Address |
| ---------------   | --------------- |
| dockertutorial-01 | 192.168.123.140 |
| dockertutorial-02 | 192.168.123.141 |
| dockertutorial-03 | 192.168.123.142 |

## Software installed:

Check scripts/packages.sh:

- ansible
- docker
- url
- emacs24-nox
- htop
- nmon
- slurm
- tcpdump
- unzip
- vim-nox

### vm specific software:

| Vagrant VM name   | Software installed        |
| ----------------- | ------------------------- |
| dockertutorial-01 | docker                    |
|                   | shipyard                  |
|                   | packer                    |
|                   | ansible                   |
|                   | docker private registry:2 |
|                   | consul server agent       |
|                   | registrator               |
|                   | consul-template           |

| Vagrant VM name   | Software installed        |
| ----------------- | ------------------------- |
| dockertutorial-02 | docker                    |
|                   | packer                    |
|                   | ansible                   |
|                   | consul server agent       |
|                   | registrator               |
|                   | consul-template           |

| Vagrant VM name   | Software installed        |
| ----------------- | ------------------------- |
| dockertutorial-03 | docker                    |
|                   | packer                    |
|                   | ansible                   |
|                   | consul server agent       |
|                   | registrator               |
|                   | consul-template           |

## Acknowledgements

The packer setup is largely based on the excellent work of Jacob Adams: [packer-qemu-templates](https://github.com/jakobadam/packer-qemu-templates)
