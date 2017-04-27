# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  MEMORY = ENV['VM_MEMORY'] || 8192
  CPU = ENV['VM_CPU'] || 4
  $node_count = 1

  (1..$node_count).each do |i|
    config.vm.define vm_name = "node%d" % i do |node|
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      node.vm.provision "shell", path: "install-dev-environment.sh"

      node.vm.provider "vmware_fusion" do |vmf, override|
        node.vm.box = "bento/ubuntu-16.04"
        vmf.vmx["memsize"] = MEMORY
        vmf.vmx["numvcpus"] = CPU
        vmf.vmx["vhv.enable"] = TRUE
      end

      node.vm.provider "virtualbox" do |vb, override|
        override.vm.box = "ubuntu/xenial64"
        vb.memory = MEMORY
        vb.cpus = CPU
        vb.gui = true
      end

      node.vm.provision "shell" do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
        s.inline = <<-SHELL
          echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        SHELL
      end
    end
  end
end
