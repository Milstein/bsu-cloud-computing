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

template "named.conf.local" do
  source "named.conf.local.erb"
  mode 0644
end
