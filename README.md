# Docker tutorial packer and Vagrant templates

## What is this

Blah blah

## Acknowledgements

The packer setup is largely based on the excellent work of Jacob Adams: [https://github.com/jakobadam/packer-qemu-templates](packer-qemu-templates)

## How to run packer

Libvirt:

```bash
packer build ubuntu14.04-dockertutorial-01.json
```

As an option if you want to create a new user e.g. ubuntu use:

```bash
read -p 'Enter password: ' -s password
packer build -var 'user=ubuntu' -var "password=$password" ubuntu14.04-dockertutorial-01.json
```

## Provision with vagrant

Libvirt:

Run:

vagrant up dockertutorial-01 --provider=libvirt

Note: this will take some time to execute, depending on your internet connection, as it will pull and provision the needed docker repositories

## Preconfigured IP addresses:

| Vagrant VM name   | IP Address      |
| ---------------   | --------------- |
| dockertutorial-01 | 192.168.123.140 |
| dockertutorial-02 | 192.168.123.141 |

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
|                   | consul                    |
|                   | consul-registrator        |
|                   | consul-template           |
