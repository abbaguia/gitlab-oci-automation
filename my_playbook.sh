#!/usr/bin/bash

export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook ~/tensorflow-demo-sanjose/playbook.yaml  -i ~/tensorflow-demo-sanjose/tf_inventory.yaml -u opc --key-file ~/.ssh/cloudshellkey
