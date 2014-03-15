#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
	action :install
end

service 'httpd' do
	action [:enable, :start]
end

bash 'chown vagrant' do
	cwd '/var'
	code <<-EOS
		chown -R vagrant:vagrant www
	EOS
end

