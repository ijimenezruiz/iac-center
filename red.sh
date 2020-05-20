#!/bin/bash
#NO INTERNET

if [ $# -ne 1 ];then
	echo "Me tienes que pasar un argumento: sinInt conInt"
	exit 1
fi

case $1 in 
	sinInt)
       if [ $(grep GATEWAY=10.33.10.97 /etc/sysconfig/network-scripts/ifcfg-eth1 | wc -l) -eq 0 ];then  
       	sudo echo "GATEWAY=10.33.10.97" >> /etc/sysconfig/network-scripts/ifcfg-eth1
       	sudo ip route del default
       	sudo ifdown eth1
       	sudo ifup eth1
       fi
    ;;
    conInt)
      sudo sed -i '/GATEWAY/,$d' /etc/sysconfig/network-scripts/ifcfg-eth1
      sudo systemctl restart network
    ;;

    *)
      echo "Argumentos permitodos: sinInt y conInt"
      exit 1
    ;;

esac
