include_recipe 'dns-proxy::networking'

directory ::File.dirname(node.default["dns-proxy"][:sniproxy_dir]) do
  action :create
end

git node.default["dns-proxy"][:sniproxy_dir] do
  repository "git://github.com/dlundquist/sniproxy.git"
  reference "master"
  action :sync
  not_if { ::File.directory?(node.default["dns-proxy"][:sniproxy_dir])}
  notifies :run, 'execute[build sniproxy]', :immediately
end

execute "build sniproxy" do
#  command "./autogen.sh && ./configure && make check && sudo make install"
  command "./autogen.sh && ./configure && sudo make install"
  cwd node.default["dns-proxy"][:sniproxy_dir]
  not_if { ::File.exists?("/usr/local/sbin/sniproxy")}
  notifies :run, 'execute[port 80 DNAT]', :immediately
  notifies :run, 'execute[port 443 DNAT]', :immediately
end

cookbook_file "sniproxy.conf" do
  path "/etc/init/sniproxy.conf"
end

service "sniproxy" do
  action :start
  provider Chef::Provider::Service::Upstart
end
