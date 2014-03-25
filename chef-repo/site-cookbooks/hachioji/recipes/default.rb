#
# Cookbook Name:: hachioji
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#yum_package 'ruby'
#yum_package 'ruby-devel'
yum_package 'nodejs'
#gem_package 'bundler'
include_recipe "rbenv::system"
ruby "2.1.0"
rbenv_gem "bundler" do
  rbenv_version "2.1.0"
  action :install
end
#rbenv_rehash