#
# Cookbook Name:: workstations
# Recipe:: centos
#
# Copyright (c) 2017 Chef Software, Inc

yum_updated_file = "/var/run/yum_already_updated"

#
# Ensure the package repository is all up-to-date. This is essential
# because sometimes the packages will fail to install because of a
# stale package repository.
#
# This is not idempotent by nature, so we'll add a guard file to make
# it easier/faster for us to iterate on this recipe.
#
execute "yum update -y" do
  action :run
  notifies :create, "file[#{yum_updated_file}]", :immediately
end

file yum_updated_file do
  action :nothing
end

#
# Ensure iptables is disabled and stopped.
#
service "iptables" do
  action [ :disable, :stop ]
end

#
# Semi-disable SELinux, because that's what you do
#
selinux_state "disable SELinux" do
  action :disabled
end

#
# Write out EC2 hints file for maximum Ohai delight
#
directory "/etc/chef/ohai/hints" do
  recursive true
  action :create
end

file "/etc/chef/ohai/hints/ec2.json" do
  content "{}"
  action :create
end


#
# Create the "hab" user.
#
# No password is set for this user. It is expected that whatever consumes
# this workstation image should set the password accordingly, preventing
# workstations to come up with hab/hab credentials and then get hacked.
#
user "hab" do
  comment "Habitat User"
  home "/home/hab"
  shell "/bin/bash"
  manage_home true
  action :create
end

#
# Allow the "hab" user passwordless sudo
#
sudo "hab" do
  user "hab"
  nopasswd true
  action :install
end

#
# Create the "dockeroot" group and put the "hab" user in it.
# This will be needed later for docker socket permissions.
#
group "dockerroot" do
  members "hab"
  action :create
end

#
# Replace the SSHD config with our own, which includes enabling
# PasswordAuthentication which AWS defaults to disabled.
#
template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

#
# Install packages, like text editors, etc. that the workstation
# participants will need
#
package %w(vim nano emacs git tree) do
  action :install
end

#
# Enable the Docker Community Edition repository which is where we'll
# pull Docker from.
#
yum_repository "docker-ce-stable" do
  baseurl 'https://download.docker.com/linux/centos/7/$basearch/stable'
  enabled true
  gpgcheck true
  gpgkey "https://download.docker.com/linux/centos/gpg"
  action :create
end

#
# Upgrade any old "docker" packages to the one from the docker repo
#
package "docker" do
  action :upgrade
end

#
# Write out a docker sysconfig that disables SELinux support
#
template "/etc/sysconfig/docker" do
  source "docker-sysconfig.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

#
# Start the docker service
#
service "docker" do
  action [ :enable, :start ]
end

#
# Ensure the docker socket is grouped into the previously-created
# dockerroot group
#
execute "chown root:dockerroot /var/run/docker.sock" do
  action :run
end

#
# Write out some workshop solutions in a "hidden" directory in case
# some participants have trouble typing out the recipe/template/kitchen
# files correctly, or if you're simply running behind on time.
#
directory "/home/hab/.solutions" do
  owner "hab"
  action :create
end

template "/home/hab/.solutions/ssh.rb" do
  source "ssh.rb.erb"
  owner "hab"
  mode "0644"
  action :create
end

template "/home/hab/.solutions/.kitchen.yml" do
  source "kitchen-yml.erb"
  owner "hab"
  mode "0644"
  action :create
end

template "/home/hab/.solutions/sshd_config.erb" do
  source "sshd_config_fixed.erb"
  owner "hab"
  mode "0644"
  action :create
end
