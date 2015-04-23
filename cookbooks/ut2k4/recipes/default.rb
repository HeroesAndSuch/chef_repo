#
# Cookbook Name:: ut2k4
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# For Ubuntu 64-bit
required_packages = ['mailutils', 'postfix', 'unzip', 'tmux', 'libstdc++5:i386']

required_packages.each do |pkg_name|
  package pkg_name do
    action :install
  end
end

user "ut2k4server" do
  action :create
  system true
end

remote_file "/usr/local/bin/ut2k4server" do
  source "http://gameservermanagers.com/dl/ut2k4server"
  mode '0770'
end