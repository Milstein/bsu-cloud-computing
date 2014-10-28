require 'spec_helper'

describe 'sniproxy' do
  describe file('/opt/sniproxy') do
    it { should be_directory }
  end

  describe file('/etc/init/sniproxy.conf') do
    it { should be_file }
  end

  describe file('/usr/local/sbin/sniproxy') do
    it { should be_file }
  end

  describe service('sniproxy') do
    it { should be_running }
  end
end
