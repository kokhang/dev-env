#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y git

# install go
apt-get install golang-go -y
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.profile
echo "export GOBIN=$GOPATH/bin" >> /home/vagrant/.profile
echo "export PATH=$PATH:$GOBIN" >> /home/vagrant/.profile

# install docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D &&\
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-cache policy docker-engine
apt-get install -y docker-engine=1.12.6-0~ubuntu-xenial

usermod -aG docker vagrant