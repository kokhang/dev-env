#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y apt-transport-https
apt-get install -y git

# install go
apt-get install golang-go -y
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.profile
echo "export GOBIN=$GOPATH/bin" >> /home/vagrant/.profile
echo "export PATH=$PATH:$GOBIN" >> /home/vagrant/.profile

# install docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y docker.io

