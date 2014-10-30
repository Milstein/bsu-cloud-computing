#!/usr/bin/env bash

set -v

ID=$(aws ec2 run-instances --image-id ami-1799da27 --instance-type t2.micro --subnet-id subnet-ac05c4db \
                           --security-group-ids sg-f595f590 --key-name bcc_key \
                           --iam-instance-profile Name=s3-ec2-access \
                           --user-data file://server-init.sh|grep InstanceId|cut -d":" -f2|tr -d '" ,')
echo "Instance ID is $ID"

aws ec2 create-tags --resources $ID --tags Key=Name,Value=zdv-test-node 2>&1 > /dev/null

echo "Waiting for instance to initialize..."
while [[ $(echo "running") != $(aws ec2 describe-instances --instance-ids $ID|grep '"Name":'|cut -d":" -f2|tr -d '" ,"') ]]; do sleep 10; done

IP=$(aws ec2 describe-instances --instance-ids $ID|grep "PublicIpAddress"|cut -d":" -f2|tr -d '" ,"')

echo "Public IP for $ID is $IP."
