#!/usr/bin/env bash

# Install chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# Set up directories
sudo rm -rf /etc/chef
sudo mkdir -p /etc/chef
sudo chmod 777 /etc/chef

# Get node name
HOSTANAME=$(hostname)

# Create client.rb
cat > /etc/chef/client.rb <<FILE
log_level :auto
log_location "/var/log/chef.log"
chef_server_url "https://api.opscode.com/organizations/zdv"
validation_client_name "zdv-org-validator"
node_name "$HOSTNAME"
FILE

# Create validation.pem
sudo cat > /etc/chef/validation.pem <<PEM
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAwAiFbS2xQKa064E/rAW++GUBjDkAGNbDWkejmuEH6tN8HcRK
iL4PDh+UI2lFMzKlhHzKRVcpqhUEpjHnD46KH/WziXn8odiX4Hbsv56VhS/0E6qv
wb5BAK/0w0FZsRlXnhNESYOzkG5SPNN0RozXs42OzLC30uH/QXUSJ7wjVf265HsP
aT2LtGG2IlRfXrw78liraj63q4fBOqPG954vDBJzQoWbIgze+GZfwl6goStU75Jr
HNl8g8D7FAGjUXK2H3gVIMiOjF86y/CICTl/n8hdogbL1zPLo0z6zmmuVNUhFq1z
gqhTGxzIJybPT9dYFKs9Lg5RfR3GO0qCYyRP4wIDAQABAoIBAQC0AIjJITZwKpOV
2U5MugobHdrIjLmJju4I1vQFfoAEXv6NjGxtJvJHw9QBKXEDH6tEuBCF1MEqO49j
FY3H6E2SzaXf7KehMbyTXAZpS4ZOFPgN40XiLqsRsN2WlNA1EFMvylGNM1WCwdZ2
S6NHakfad4tuVQvKMaspuUouUs0wkQhV26ycVJlquWpqbL6uiiBxSXQMl1mEu3Bj
Qkm9SU1yTj5gA/OMzEuhnOPPxWZDRdBKagTlZBpwu6pLQi+ALCkBuSZPTS7Ldl5h
u6rICuB3Lt+YIKapHTsyxVQ5Vmj1Er0VG2afxA07hYiy3wleeYwoPYXQ9d2VtYuu
iWnCyZJpAoGBAOsu+avc5aj+bfdzSNoHQLOr2+er46GTJfWOK4b9Ji3GBPwn80fm
5Nzi09uvJxsdylSra74VqsJe4lQdj/VOtMzCfZ8VwEmELJomPRoqiMKaadBxsrLG
Y/tdmwpl16OU33DLiA1f7qQnePDv9Ha163ONykPqCxfFjp4qBTKszWtlAoGBANEH
zhCXGBCWQrwpyY1rv7JROQL6R5Mc+50MHC6pNOm1lj60+veeY1xiqAz2lBbQpOI1
+yW7RXstWYY1TA79dpvU3KgXGDJTm65aX3xOeY++RjDHh197K2JOXoB8MhoJnhvG
ztqkyIGkh4XrLrYTR//XEA4rv3R18vT+M22oUK2nAoGBANXiqOnmQW9JxRSwYeb3
hZ5hg+LT7nc5beI+Y9OmUpx6ZHo2kwgnMqi4GVjHmFcO5r3OEHSVG/EdfdRl9lBw
PfmiP8D4dSHm9PFUKWmsmSfyap1Jae0whClM3f281TpN4E+iqp8PSec8hr8IW1nC
5Nj4cKUHKwN5hdTN/mAxy7gJAoGAbGej0q7JaDDFQ1hYkuNCc3P0ITszS3RIeVYC
d6CBNINb/AFX9ntKBGuVw8NNYdeq6zYbnaHVkuAeAaA6ZbvFe2OVXAc+ITuDDZUI
2CrKmGWReVLBPh9ejIkgMXo3cZFzUex08qdq5PEy55zkiMDPIjuis/a0P+27ppr+
iOw1ixkCgYBOjhnl1oAkYLHEfroSWvyrOrN9c01JKOJgLbFvoWiV8K2wPM5rLcZc
kwKWdXxQbsflECrf1TgdKEhqPWoGeWJuNrikNlg3bs4HDXzb0Lnp94/FKI1+eHI2
DRVBQLFUhYlQ34lde2UGLat5T0AQ8p0Sn7O7NPTIJeHdku+7SiVERQ==
-----END RSA PRIVATE KEY-----
PEM

# Create boot json file
sudo cat > /etc/chef/first-boot.json << FIRSTBOOT
{"run_list": "role[dns-proxy-ec2]"}
FIRSTBOOT

# Fix up permissions
sudo chown -R root.root /etc/chef
sudo chmod -R go-rwx /etc/chef

# Run chef
sudo chef-client -j /etc/chef/first-boot.json
