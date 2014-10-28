require 'spec_helper'

describe 'dns-proxy::sniproxy' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  describe 'dns-proxy sniproxy' do
    it { expect(chef_run).to create_directory('/opt') }
    it { expect(chef_run).to sync_git('/opt/sniproxy') }
    it { expect(chef_run).to include_recipe('dns-proxy::networking') }
    it { expect(chef_run).to render_file('/etc/init/sniproxy.conf') }
    it { expect(chef_run).to start_service('sniproxy') }
  end
end
