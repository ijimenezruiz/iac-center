$provision_ansible_machine = <<-SCRIPT
# Install pyhon because ansible needs
sudo yum -y install python epel-repo
sudo yum -y install ansible
SCRIPT

$provision_debian_machine = <<-SCRIPT
# Install pyhon because ansible needs
sudo apt install python -y
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
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
      v.memory = "4096"
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
end
