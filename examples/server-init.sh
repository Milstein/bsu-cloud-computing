#!/usr/bin/env bash

# Install chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# Set up directories
sudo rm -rf /etc/chef
sudo mkdir -p /etc/chef
sudo chmod 777 /etc/chef

# Get node name
HOSTANAME=$(hostname)

# Install awscli
sudo apt-get -y install awscli

export AWS_DEFAULT_REGION=us-west-2

aws s3 cp s3://opscode-chef-zdv/client.rb /etc/chef
aws s3 cp s3://opscode-chef-zdv/validation.pem /etc/chef
aws s3 cp s3://opscode-chef-zdv/first-boot.json /etc/chef

sed -i s/NODE_NAME/$HOSTNAME/ /etc/chef/client.rb

# Fix up permissions
sudo chown -R root.root /etc/chef
sudo chmod -R go-rwx /etc/chef

# Run chef
sudo chef-client -j /etc/chef/first-boot.json
