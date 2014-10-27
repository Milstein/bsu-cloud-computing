require 'spec_helper'

describe 'dns-proxy::dependencies' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  describe 'dns-proxy packages' do
    it { expect(chef_run).to install_package 'htop' }
    it { expect(chef_run).to install_package 'git' }
    it { expect(chef_run).to install_package 'dh-autoreconf' }
    it { expect(chef_run).to install_package 'libpcre3-dev' }
    it { expect(chef_run).to install_package 'libudns-dev' }
    it { expect(chef_run).to install_package 'libev-dev' }
    it { expect(chef_run).to install_package 'pkg-config' }
  end
end
