#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -q
sudo apt-get upgrade -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
