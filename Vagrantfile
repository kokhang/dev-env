# -*- mode: ruby -*-
# vi: set ft=ruby :

$memory = 8192
$cpu = 4
$node_count = 1

CONFIG = File.expand_path("config.rb")
if File.exist?(CONFIG)
  require CONFIG
end

Vagrant.configure("2") do |config|

  (1..$node_count).each do |i|
    config.vm.define vm_name = "node%d" % i do |node|
      node.vm.provision "shell", path: "install-dev-environment.sh"
      node.vm.hostname = vm_name
      node.vm.provider "vmware_fusion" do |vmf, override|
        node.vm.box = "bento/ubuntu-16.04"
        vmf.vmx["memsize"] = $memory
        vmf.vmx["numvcpus"] = $cpu
        vmf.vmx["vhv.enable"] = TRUE
      end

      node.vm.provider "virtualbox" do |vb, override|
        override.vm.box = "ubuntu/xenial64"
        vb.memory = $memory
        vb.cpus = $cpu
        vb.gui = true
      end
    end
  end
end
