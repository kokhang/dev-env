#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
add-apt-repository ppa:longsleep/golang-backports
apt-get update && apt-get install -y apt-transport-https
apt-get install -y git

#apt-get install -y ceph-common

# install go
apt-get install golang-go -y
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.profile
echo "export GOBIN=/home/vagrant/go/bin" >> /home/vagrant/.profile
echo "export PATH=$PATH:$GOBIN" >> /home/vagrant/.profile
echo "export PATH=/home/vagrant/go/src/k8s.io/kubernetes/third_party/etcd:${PATH}" >> /home/vagrant/.profile

# install docker
apt-get install -y docker.io

# install kubernetes tools
apt-get install -y kubeadm

# install kubernetes using kubeadm
if [ `hostname -s` = "node1" ]; then
	cat << EOF > kubeadm.yaml
kind: MasterConfiguration
apiVersion: kubeadm.k8s.io/v1alpha1
controllerManagerExtraArgs:
  horizontal-pod-autoscaler-use-rest-clients: "true"
  horizontal-pod-autoscaler-sync-period: "10s"
  node-monitor-grace-period: "10s"
apiServerExtraArgs:
  runtime-config: "api/all=true"
  feature-gates: "TaintBasedEvictions=true"
kubernetesVersion: "stable-1.7"
EOF
	kubeadm init --config kubeadm.yaml
	user=vagrant
	cp /etc/kubernetes/admin.conf /home/$user/
	chown $user:$user /home/$user/admin.conf
	KUBECONFIG=/home/$user/admin.conf kubectl apply -f https://cloud.weave.works/k8s/v1.6/net
fi