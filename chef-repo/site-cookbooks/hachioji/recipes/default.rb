#
# Cookbook Name:: hachioji
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
yum_package 'ruby'
yum_package 'ruby-devel'
gem_package 'bundler'
yum_package 'nodejs'