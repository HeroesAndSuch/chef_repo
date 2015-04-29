#
# Cookbook Name:: ut2k4
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# For Ubuntu 64-bit
include_recipe 'apache2'
required_packages = ['mailutils', 'postfix', 'unzip', 'tmux', 'libstdc++5:i386']
server_user = node[:ut2k4][:server][:service_user]
server_dir = node[:ut2k4][:server][:dir]
web_dir = node[:ut2k4][:server][:web]
required_dirs = ["/home/#{server_user}", "/home/#{server_user}/#{server_dir}", web_dir]

required_packages.each do |pkg_name|
  package pkg_name do
    action :install
  end
end

user server_user do
  action :create
  system true
  home "/home/#{server_user}"
  shell "/bin/bash"
end

required_dirs.each do |dir_name|
  directory dir_name do
    owner server_user
    group server_user
    mode '0755'
    action :create
  end
end

tar_extract 'https://s3.amazonaws.com/gamingsyndicate/ut2k4-server.tar.gz' do
  target_dir "/home/#{server_user}/#{server_dir}"
  creates "/home/#{server_user}/#{server_dir}/System"
  tar_flags [ '--strip-components 1' ]
end

template "/home/#{server_user}/#{server_dir}/System/ut2k4-server.ini" do
  source 'ut2k4-server.ini.erb'
  owner server_user
  group server_user
  mode '0644'
end

template "/etc/init/ut2k4server.conf" do
  source 'ut2k4server.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end