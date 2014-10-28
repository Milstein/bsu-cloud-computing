require 'spec_helper'

describe 'dependencies' do
  it { expect(package 'htop').to be_installed }
  it { expect(package 'git').to be_installed }
  it { expect(package 'dh-autoreconf').to be_installed }
  it { expect(package 'libpcre3-dev').to be_installed }
  it { expect(package 'libudns-dev').to be_installed }
  it { expect(package 'libev-dev').to be_installed }
  it { expect(package 'pkg-config').to be_installed }
end
