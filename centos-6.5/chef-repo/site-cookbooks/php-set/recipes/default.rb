#
# Cookbook Name:: php-set
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "pf: " + node['platform_family']
#log "php: " + node['php']['pecl']

php = 'php'
if node.has_key?('package')
	if node['package'].has_key?('php-base')
		php = node['package']['php-base']
	end
end
opts = ''
if node.has_key?('package')
	if node['package'].has_key?('options')
		opts = node['package']['options']
	end
end

fuel      = node['php-set']['fuel']
fuel_name = fuel + '-' + node['php-set']['fuel_ver']
fuel_file = fuel_name + '.zip'

log "php-base: #{php}"
log "opts: #{opts}"

pkgs = []
pkgs.push("#{php}")
pkgs.push("#{php}-mbstring")
pkgs.push("#{php}-mysql")
pkgs.push("#{php}-pdo")
pkgs.push("#{php}-pecl-apc")
pkgs.push("php-pear")

pkgs.each do |pkg|
	package "#{pkg}" do
		action :install
		options opts
	end
end
# notifies :restart, "service[httpd]", :delayed

service 'httpd' do
	# action :nothing
	action :restart
end

cookbook_file "/usr/local/src/#{fuel_file}" do
	source fuel_file
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{fuel_file}" }
end
bash 'unzip fuelphp' do
	cwd '/usr/share/pear'
	code <<-EOS
		unzip /usr/local/src/#{fuel_file}
	EOS
	not_if { File.exists? "/usr/share/pear/#{fuel_name}" }
end
link "/usr/share/pear/#{fuel}" do
	to "/usr/share/pear/#{fuel_name}"
end
