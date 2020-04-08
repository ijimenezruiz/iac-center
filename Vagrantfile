$confcen = <<-SCRIPT
sudo cat > "/etc/sysconfig/network-scripts/ifcfg-eth1" << _EOF_
DEVICE=eth1
BOOTPROTO=none
ONBOOT=yes
NETMASK=255.255.255.0
IPADDR=192.168.80.8
_EOF_
sudo ifdown eth1
sudo ifup eth1
sudo yum -y install python
SCRIPT
Vagrant.configure(2) do |config|
	#Nombre a dar
	config.vm.box = "maquina1"
  	config.vm.hostname= "Ansible-Centos"
  	#Nombre de SO a bajar
  	config.vm.box = "centos/7"

    config.vm.provision :shell do |s|
      s.inline = $confcen
    end

  #Especificamos configuracion al proveedor
  	config.vm.provider :virtualbox do |vb|
   		vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
      	vb.customize ["modifyvm", :id, "--nic1", "nat"]
     	vb.customize ["modifyvm", :id, "--nic2", "intnet"]

   	#add second disk
   		file_to_disk='/home/ivan/Escritorio/lab/discos_virtuales/centosExtra.vdi'
   		unless File.exist?(file_to_disk)
        vb.customize ['createhd', '--filename', file_to_disk, '--size', 50 * 1024]
  		end
  		vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
  	end
end