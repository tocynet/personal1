#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

opts = ''
if node.has_key?('package')
	if node['package'].has_key?('options')
		opts = node['package']['options']
	end
end

package 'mysql-libs' do
	action :remove
end
%w{mysql mysql-server}.each do |pkg|
	package "#{pkg}" do
		action :install
		options opts
	end
end

service 'mysqld' do
	action [:enable, :start]
end

