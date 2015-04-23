#
# Cookbook Name:: ut2k4
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# For Ubuntu 64-bit
required_packages = ['mailutils', 'postfix', 'unzip', 'tmux', 'libstdc++5:i386']
required_dirs = ['/home/ut2k4server', '/usr/local/bin/serverfiles']

required_packages.each do |pkg_name|
  package pkg_name do
    action :install
  end
end

user "ut2k4server" do
  action :create
  system true
  home "/home/ut2k4server"
  shell "/bin/bash"
end


required_dirs.each do |dir_name|
  directory dir_name do
    owner "ut2k4server"
    group "ut2k4server"
    mode '0755'
    action :create
  end
end

remote_file "/usr/local/bin/ut2k4server" do
  owner 'ut2k4server'
  group 'ut2k4server'
  source "http://gameservermanagers.com/dl/ut2k4server"
  mode '0770'
end