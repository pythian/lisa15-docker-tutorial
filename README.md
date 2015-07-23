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

Virtualbox:

```bash
packer build vbox-ubuntu14.04-dockertutorial-01.json
```

As an option if you want to create a new user e.g. ubuntu use:

```bash
read -p 'Enter password: ' -s password
packer build -var 'user=ubuntu' -var "password=$password" ubuntu14.04-dockertutorial-01.json
```

## Provision with vagrant

Libvirt:

Run:

vagrant up dockertutorial --provider=libvirt --no-parallel

Virtualbox:

Run:

vagrant up dockertutorial --provider=virtualbox --no-parallel

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
