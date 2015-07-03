PACKAGES="
curl
emacs24-nox
htop
nmon
slurm
tcpdump
unzip
vim-nox
"
apt-get -y install $PACKAGES
wget -qO- https://get.docker.com/ | sh
