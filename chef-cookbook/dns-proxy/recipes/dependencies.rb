execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
end

package "htop"
package "git"
package "dh-autoreconf"
package "libpcre3-dev"
package "libudns-dev"
package "libev-dev"
package "pkg-config"
