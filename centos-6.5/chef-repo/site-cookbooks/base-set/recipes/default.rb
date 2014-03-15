#
# Cookbook Name:: base-set
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'vim-enhanced' do
	action :install
end

cookbook_file '/home/vagrant/.bash_profile' do
	source '.bash_profile'
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
end

cookbook_file '/home/vagrant/.vimrc' do
	source '.vimrc'
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
end
cookbook_file '/root/.vimrc' do
	source '.vimrc'
	# owner 'vagrant'
	# group 'vagrant'
	mode  '0644'
end

cookbook_file '/etc/profile.d/vim.sh' do
	source 'vim.sh'
	# owner 'vagrant'
	# group 'vagrant'
	mode  '0755'
end

