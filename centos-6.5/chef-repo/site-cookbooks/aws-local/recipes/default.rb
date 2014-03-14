#
# Cookbook Name:: aws-local
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

dynamodb      = node['aws-local']['dynamodb_name']
dynamodb_name = dynamodb + node['aws-local']['dynamodb_ver']
dynamodb_file = dynamodb_name + '.tar.gz'
sdk           = node['aws-local']['sdk']
java_ver      = node['aws-local']['java_ver']

log 'dynamodb: '      + dynamodb
log 'dynamodb_name: ' + dynamodb_name
log 'dynamodb_file: ' + dynamodb_file

directory '/usr/local/src' do
	action :create
	not_if { File.exists? '/usr/local/src' }
end
cookbook_file "/usr/local/src/#{dynamodb_file}" do
	source dynamodb_file
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{dynamodb_file}" }
end
cookbook_file "/usr/local/src/#{sdk}" do
	source sdk
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{sdk}" }
end
bash 'unzip dynamodb_local' do
	cwd '/opt'
	code <<-EOS
		tar xzpvf /usr/local/src/#{dynamodb_file}
	EOS
	not_if { File.exists? "/opt/#{dynamodb_name}" }
end
link "/opt/#{dynamodb}" do
	to "/opt/#{dynamodb_name}"
end

package "java-#{java_ver}-openjdk" do
	action :install
end

