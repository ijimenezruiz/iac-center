$provision_ansible_machine = <<-SCRIPT
# Install pyhon because ansible needs
yum -y install python epel-repo
yum -y install ansible
if [ ! -f /home/vagrant/.ssh/id_rsa ];then su vagrant -s /bin/bash <<< 'ssh-keygen -t rsa -N "" -C "" -f $HOME/.ssh/id_rsa'; else echo "El fichero ya existe";fi

SCRIPT

$provision_debian_machine = <<-SCRIPT
# Install pyhon because ansible needs
apt install python -y
if [ ! -f /home/vagrant/.ssh/id_rsa ];then su vagrant -s /bin/bash <<< 'ssh-keygen -t rsa -N "" -C "" -f $HOME/.ssh/id_rsa'; else echo "El fichero ya existe";fi
SCRIPT

Vagrant.configure("2") do |config|


  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  config.vm.define "fw1", autostart: true do |fw1|
    fw1.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
      v.customize ["modifyvm", :id, "--nic3", "intnet"]
  end

    fw1.vm.box = "fw1"
    fw1.vm.hostname= "fw1"
    fw1.vm.network "private_network", ip: "10.25.200.1", virtualbox__intnet: true
    fw1.vm.network "private_network", ip: "100.25.200.1", virtualbox__intnet: true
    fw1.vm.box = "generic/debian10"
  end

  config.vm.define "proxy", autostart: true do |proxy|
    proxy.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
      v.customize ["modifyvm", :id, "--nic3", "intnet"]
      v.customize ["modifyvm", :id, "--nic4", "intnet"]
  end

    proxy.vm.box = "proxy"
    proxy.vm.hostname= "proxy"
    proxy.vm.network "private_network", ip: "172.25.200.1", virtualbox__intnet: true
    proxy.vm.network "private_network", ip: "100.25.200.2", virtualbox__intnet: true
    proxy.vm.network "private_network", ip: "120.25.200.1", virtualbox__intnet: true
    proxy.vm.box = "generic/debian10"
  end

  config.vm.define "ansible", primary: true do |ansible|
    ansible.vm.provider "virtualbox" do |v|
      v.memory = "2048"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
    end
    ansible.vm.box = "maquina1"
    ansible.vm.hostname= "Ansible-Centos"
    ansible.vm.network "private_network", ip: "10.25.200.3", virtualbox__intnet: true
    ansible.vm.box = "centos/7"

    ansible.vm.provision :shell do |s|
      s.inline = $provision_ansible_machine
    end
  end

  config.vm.define "web", autostart: true do |web|
    web.vm.provider "virtualbox" do |v|
      v.memory = "2048"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end

    web.vm.box = "web"
    web.vm.hostname= "web-dns"
    web.vm.network "private_network", ip: "10.25.200.2", virtualbox__intnet: true
    web.vm.box = "generic/debian10"


    web.vm.provision :shell do |s|
      s.inline = $provision_debian_machine
    end
  end

  config.vm.define "dhcp", autostart: true do |dhcp|
    dhcp.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end

    dhcp.vm.box = "dhcp"
    dhcp.vm.hostname= "dhcp"
    dhcp.vm.network "private_network", ip: "10.25.200.10", virtualbox__intnet: true
    dhcp.vm.box = "generic/debian10"


    dhcp.vm.provision :shell do |s|
      s.inline = $provision_debian_machine
    end
  end

  config.vm.define "backup", autostart: true do |backup|
    backup.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end

    backup.vm.box = "backup"
    backup.vm.hostname= "backup"
    backup.vm.network "private_network", ip: "10.25.200.55", virtualbox__intnet: true
    backup.vm.box = "generic/debian10"
  end

  config.vm.define "dns2", autostart: true do |dns2|
    dns2.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end

    dns2.vm.box = "dns2"
    dns2.vm.hostname= "dns2"
    dns2.vm.network "private_network", ip: "10.25.200.65", virtualbox__intnet: true
    dns2.vm.box = "generic/debian10"
  end
end