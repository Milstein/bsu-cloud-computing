#!/usr/bin/env bash

aws ec2 run-instances --image-id ami-1799da27 --instance-type t2.micro --subnet-id subnet-ac05c4db --security-group-ids sg-f595f590 --key-name bcc_key --user-data file://server-init.sh

# aws ec2 create-tags --resources i-f1e617fd --tags Key=Name,Value=zdv-test-node
# aws ec2 describe-instances --instance-ids i-f1e617fd

# curl http://169.254.169.254/latest/meta-data/
# curl http://169.254.169.254/latest/user-data/
