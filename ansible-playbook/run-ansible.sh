#!/usr/bin/env bash

# This script uses Ansible to create an EC2 instance, provision it, 
# create an image, and terminate it.

ANSIBLE_FLAGS="-vvvv -T 60"
LOCAL_INVENTORY="inventory/local.yml"
TEMP_INVENTORY="inventory/temp.yml"
INSTANCE_ID_FILE="/tmp/ansible-instance-id.tmp"
EC2_KEY="~/bcc/bcc_key.pem"
INSTANCE_NAME="zdv-ansible-node"

export ANSIBLE_HOST_KEY_CHECKING=False

set -v

ansible-playbook $ANSIBLE_FLAGS ec2.yml -i $LOCAL_INVENTORY -e "instance_id_file=$INSTANCE_ID_FILE ami_inventory_file=$TEMP_INVENTORY instance_name=$INSTANCE_NAME instance_type=t2.micro base_ami=ami-1799da27 security_group='ssh open' key_pair=bcc_key subnet_id=subnet-ac05c4db"
ansible-playbook $ANSIBLE_FLAGS dependencies.yml sniproxy.yml -i $TEMP_INVENTORY --private-key $EC2_KEY -u ubuntu
ansible-playbook $ANSIBLE_FLAGS ami.yml -i $LOCAL_INVENTORY -e "instance_id_file=$INSTANCE_ID_FILE instance_name=$INSTANCE_NAME virt_type=hvm"
