$provision_ansible_machine = <<-SCRIPT
# Install pyhon because ansible needs
yum -y install python epel-release 
yum -y install ansible
yum -y install net-tools
for i in $(find /vagrant/.vagrant/machines/ -name private_key);do chmod 600 $i;done
SCRIPT

$provision_debian_machine = <<-SCRIPT
# Install pyhon because ansible needs
apt install python -y
SCRIPT


Vagrant.configure("2") do |config|


  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
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
    proxy.vm.network "private_network", ip: "10.33.10.1", netmask: "255.255.255.224", virtualbox__intnet: true
    proxy.vm.network "private_network", ip: "10.33.10.33", netmask: "255.255.255.224", virtualbox__intnet: true
    proxy.vm.network "private_network", ip: "10.33.10.65", netmask: "255.255.255.224", virtualbox__intnet: true
    proxy.vm.box = "generic/debian10"
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
    fw1.vm.network "private_network", ip: "10.33.10.66", netmask: "255.255.255.224", virtualbox__intnet: true
    fw1.vm.network "private_network", ip: "10.33.10.97", netmask: "255.255.255.224", virtualbox__intnet: true
    fw1.vm.box = "generic/debian10"
  end

  config.vm.define "webdns", autostart: true do |webdns|
    webdns.vm.provider "virtualbox" do |v|
      v.memory = "2048"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end 

    webdns.vm.box = "webdns"
    webdns.vm.hostname= "webdns"
    webdns.vm.network "private_network", ip: "10.33.10.99", netmask: "255.255.255.224", virtualbox__intnet: true
    webdns.vm.box = "generic/debian10"


    webdns.vm.provision :shell do |s|
      s.inline = $provision_debian_machine
    end
  end

   config.vm.define "apacheInt", autostart: true do |apacheInt|
    apacheInt.vm.provider "virtualbox" do |v|
      v.memory = "2048"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end 

    apacheInt.vm.box = "apacheInt"
    apacheInt.vm.hostname= "apacheInt"
    apacheInt.vm.network "private_network", ip: "10.33.10.101", netmask: "255.255.255.224", virtualbox__intnet: true
    apacheInt.vm.box = "generic/debian10"


    apacheInt.vm.provision :shell do |s|
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
    dhcp.vm.network "private_network", ip: "10.33.10.130", netmask: "255.255.255.224", virtualbox__intnet: true
    dhcp.vm.box = "generic/debian10"


    dhcp.vm.provision :shell do |s|
      s.inline = $provision_debian_machine
    end
  end

  config.vm.define "dns2", autostart: true do |dns2|
    dns2.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
  end

    dns2.vm.box = "dns2"
    dns2.vm.hostname= "dns2"
    dns2.vm.network "private_network", ip: "10.33.10.100", netmask: "255.255.255.224", virtualbox__intnet: true
    dns2.vm.box = "generic/debian10"
  end

  config.vm.define "client2", autostart: true do |client2|
    client2.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
    end

    client2.vm.box = "client2"
    client2.vm.hostname = "client2"
    client2.vm.network "private_network", type: "dhcp", virtualbox__intnet: true, mac: "080027D14C66"
    client2.vm.box = "generic/debian10"
  end

  config.vm.define "ansible", primary: true do |ansible|
    ansible.vm.provider "virtualbox" do |v|
      v.memory = "2048"
      v.customize ["modifyvm", :id, "--nic1", "nat"]
      v.customize ["modifyvm", :id, "--nic2", "intnet"]
    end
    ansible.vm.box = "maquina1"
    ansible.vm.hostname= "Ansible-Centos"
    ansible.vm.network "private_network", ip: "10.33.10.98", netmask: "255.255.255.224", virtualbox__intnet: true
    ansible.vm.box = "centos/7"
    ansible.vm.provision "file", source: ".vagrant", destination: "/vagrant/.vagrant"
    ansible.vm.provision :shell do |s|
      s.inline = $provision_ansible_machine
    end
  end
end
