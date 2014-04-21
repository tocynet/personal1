#
# Cookbook Name:: aws-local
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#dynamodb      = node['aws-local']['dynamodb_name']
#dynamodb_name = dynamodb + node['aws-local']['dynamodb_ver']
#dynamodb_file = dynamodb_name + '.tar.gz'
sdk           = node['aws-local']['sdk']
#java_ver      = node['aws-local']['java_ver']

#log 'dynamodb: '      + dynamodb
#log 'dynamodb_name: ' + dynamodb_name
#log 'dynamodb_file: ' + dynamodb_file

directory '/usr/local/src' do
	action :create
	not_if { File.exists? '/usr/local/src' }
end
#cookbook_file "/usr/local/src/#{dynamodb_file}" do
#	source dynamodb_file
#	owner 'vagrant'
#	group 'vagrant'
#	mode  '0644'
#	not_if { File.exists? "/usr/local/src/#{dynamodb_file}" }
#end
cookbook_file "/usr/local/src/#{sdk}" do
	source sdk
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{sdk}" }
end
cookbook_file "/var/www/html/#{sdk}" do
	source sdk
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/var/www/html/#{sdk}" }
end
cookbook_file "/var/www/html/aws-key.csv" do
	source 'aws-key.csv'
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/var/www/html/aws-key.csv" }
end
#bash 'unzip dynamodb_local' do
#	cwd '/opt'
#	code <<-EOS
#		tar xzpvf /usr/local/src/#{dynamodb_file}
#	EOS
#	not_if { File.exists? "/opt/#{dynamodb_name}" }
#end
#link "/opt/#{dynamodb}" do
#	to "/opt/#{dynamodb_name}"
#end
#cookbook_file "/etc/init.d/dynamodb_local" do
#	source 'dynamodb_local'
#	#owner 'vagrant'
#	#group 'vagrant'
#	mode  '0755'
#	not_if { File.exists? "/etc/init.d/dynamodb_local" }
#end


#package "java-#{java_ver}-openjdk" do
#	action :install
#end

cookbook_file "/var/www/html/aws.test.php" do
	source 'aws.test.php'
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/var/www/html/aws.test.php" }
end

#service 'dynamodb_local' do
#	# action [:enable, :start]
#	supports :status => true, :restart => true
#	action [:enable, :restart]
#end

#bash 'start dynamodb_local' do
#	cwd '/opt'
#	code <<-EOS
#		/etc/init.d/dynamodb_local restart
#	EOS
#	not_if { File.exists? "/var/run/#{dynamodb_name}/#{dynamodb_name}" }
#end

