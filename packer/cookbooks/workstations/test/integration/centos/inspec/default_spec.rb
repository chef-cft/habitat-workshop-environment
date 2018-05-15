
describe user('hab') do
  it { should exist }
  its('home') { should eq '/home/hab' }
  its('shell') { should eq '/bin/bash' }
  its('groups') { should eq [ 'hab', 'dockerroot' ] }
end

describe file('/etc/chef/client.pem') do
  it { should_not be_file }
end

describe file('/etc/ssh/sshd_config') do
  its('content') { should match /^PasswordAuthentication yes$/ }
  its('content') { should match /^#Protocol 2/ }
  its('content') { should_not match /^Protocol/ }
end

describe file('/etc/sudoers.d/hab') do
  its('content') { should match /hab ALL=\(ALL\) NOPASSWD:ALL/ }
end

describe package('docker') do
  it { should be_installed }
end

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/run/docker.sock') do
  it { should be_grouped_into 'dockerroot' }
end

describe file('/etc/chef/ohai/hints/ec2.json') do
  it { should be_file }
  its('content') { should match /{}/ }
end

describe package('vim-enhanced') do
  it { should be_installed }
end

describe package('emacs') do
  it { should be_installed }
end

describe package('nano') do
  it { should be_installed }
end

describe package('git') do
  it { should be_installed }
end

describe package('tree') do
  it { should be_installed }
end
