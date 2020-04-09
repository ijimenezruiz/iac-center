#!/bin/bash
sudo sed -i '/#inventory      =/c\inventory      = $OS_INVENTORY_PATH' /etc/ansible/ansible.cfg
export OS_INVENTORY_PATH=$(pwd)/inventario

