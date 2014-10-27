execute "port 80 DNAT" do
  command "iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to #{node.default["dns-proxy"][:local_ip_addr]}"
  action :nothing
end

execute "port 443 DNAT" do
  command "iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to #{node.default["dns-proxy"][:local_ip_addr]}"
  action :nothing
end
