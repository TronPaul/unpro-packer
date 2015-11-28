#!/bin/sh
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" python-pip python-dev cmake unzip pkg-config libssh2-1-dev libssl-dev

wget -q http://mirrors.kernel.org/ubuntu/pool/universe/libg/libgit2/libgit2-dev_0.20.0-1_amd64.deb -O libgit2-dev.deb
wget -q http://mirrors.kernel.org/ubuntu/pool/universe/libg/libgit2/libgit2-0_0.20.0-1_amd64.deb -O libgit2-0.deb
sudo dpkg -i libgit2-0.deb
sudo dpkg -i libgit2-dev.deb

sudo apt-get install -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" python-cffi libffi-dev
sudo pip -q install -U 'pygit2 == 0.20.3'
