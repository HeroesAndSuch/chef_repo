#
# Cookbook Name:: ut2k4
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# For Ubuntu 64-bit
required_packages = ['mailutils', 'postfix', 'unzip', 'tmux', 'libstdc++5:i386']
required_dirs = ['/home/ut2k4server']

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


tar_extract 'https://s3.amazonaws.com/gamingsyndicate/ut2004-lnxpatch3369-2.tar.bz2' do
  target_dir '/home/ut2k4server'
  creates '/home/ut2k4server/UT2004-Patch'
  tar_flags [ '--strip-components 1' ]
end