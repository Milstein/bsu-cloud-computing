execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
end

package "htop"
package "git"
package "dh-autoreconf"
package "libpcre3-dev"
package "libev-dev"
package "pkg-config"

git "#{node.default[:bcc][:sniproxy_dir]}" do
  repository "git://github.com/dlundquist/sniproxy.git"
  reference "master"
  action :sync
  not_if { ::File.directory?(node.default[:bcc][:sniproxy_dir])}
  notifies :run, 'execute[build sniproxy]', :immediately
end

execute "build sniproxy" do
  command "./autogen.sh && ./configure && make check && sudo make install"
  cwd "#{node.default[:bcc][:sniproxy_dir]}"
  not_if { ::File.exists?("/usr/local/sbin/sniproxy")}
  notifies :run, 'execute[port 80 DNAT]', :immediately
  notifies :run, 'execute[port 443 DNAT]', :immediately
  action :nothing
end

execute "port 80 DNAT" do
  command "iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to #{node.default[:bcc][:local_ip_addr]}"
  action :nothing
end

execute "port 443 DNAT" do
  command "iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to #{node.default[:bcc][:local_ip_addr]}"
  action :nothing
end

directory "/etc/bind" do
  owner "root"
  group "bind"
  mode 04755
end

template "/etc/sniproxy.conf" do
  source "sniproxy.conf.erb"
  mode 0644
end

template "/etc/bind/named.conf.options" do
  source "named.conf.options.erb"
  mode 0644
end

template "/etc/bind/db.override" do
  source "db.override.erb"
  mode 0644
end

cookbook_file "sniproxy.conf" do
  path "/etc/init/sniproxy.conf"
end

cookbook_file "named.conf.local" do
  path "/etc/bind/named.conf.local"
end

execute "start sniproxy" do
  command "start sniproxy"
  ignore_failure true
end
