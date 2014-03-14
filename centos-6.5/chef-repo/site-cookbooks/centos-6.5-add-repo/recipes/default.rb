#
# Cookbook Name:: centos-6.5-add-repo
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

files = {}
files['epel'] = node['centos-6.5-add-repo']['epel']
files['remi'] = node['centos-6.5-add-repo']['remi']

directory '/usr/local/src' do
	action :create
	not_if { File.exists? '/usr/local/src' }
end
cookbook_file "/usr/local/src/#{files['epel']}" do
	source files['epel']
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{files['epel']}" }
end
cookbook_file "/usr/local/src/#{files['remi']}" do
	source files['remi']
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{files['remi']}" }
end
%w{ epel remi }.each do |pkg|
	log "pkg: " + pkg
	log "file: #{files[pkg]}"
	package "#{pkg}" do
		action :install
		source "/usr/local/src/#{files[pkg]}"
		not_if "rpm -qa | grep '#{pkg}-release'"
	end
end
