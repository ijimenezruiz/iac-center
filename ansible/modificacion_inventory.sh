#!/bin/bash
sudo sed -i '/#inventory      =/c\inventory      = $OS_INVENTORY_PATH' /etc/ansible/ansible.cfg
sudo sed -i '/roles_path    =/c\roles_path    = $OS_ROLES_PATH' /etc/ansible/ansible.cfg

export OS_INVENTORY_PATH=$(pwd)/inventario
export OS_ROLES_PATH=$(pwd)/roles/