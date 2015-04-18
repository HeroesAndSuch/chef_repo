#
# Cookbook Name:: mumble
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apt"


case node['platform']
when "ubuntu", "debian"
    apt_repository "mumble" do
        uri "ppa:mumble/release"
        distribution node['lsb']['codename']
    end
end