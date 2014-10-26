default[:bcc][:sniproxy_dir]  = "/home/ubuntu/sniproxy"
default[:bcc][:local_ip_addr] = node[:ec2][:local_ipv4]
default[:bcc][:public_ip_addr] = node[:ec2][:public_ipv4]
default[:bcc][:local_dns_server] = "fml"
