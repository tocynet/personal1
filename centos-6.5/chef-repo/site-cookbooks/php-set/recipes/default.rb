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
pkgs.push("#{php}-devel")
pkgs.push("#{php}-mbstring")
pkgs.push("#{php}-mysql")
pkgs.push("#{php}-pdo")
pkgs.push("#{php}-pecl-apc")
pkgs.push("#{php}-pecl-memcache")
pkgs.push("#{php}-pecl-memcached")
pkgs.push("php-pear")
pkgs.push("php-pear-DB")
pkgs.push("php-phpmd-PHP-PMD")
pkgs.push("php-pear-HTTP-Request")
pkgs.push("phpMemcachedAdmin")

pkgs.each do |pkg|
	package "#{pkg}" do
		action :install
		options opts
	end
end
# notifies :restart, "service[httpd]", :delayed

cookbook_file '/etc/httpd/conf.d/fuel.app.conf' do
	source 'fuel.app.conf'
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? '/etc/httpd/conf.d/fuel.app.conf' }
end

service 'httpd' do
	# action :nothing
	action :restart
end

package 'unzip' do
	action :install
end

cookbook_file "/usr/local/src/#{fuel_file}" do
	source fuel_file
	owner 'vagrant'
	group 'vagrant'
	mode  '0644'
	not_if { File.exists? "/usr/local/src/#{fuel_file}" }
end
bash 'unzip fuelphp' do
	cwd '/var/www'
	code <<-EOS
		unzip /usr/local/src/#{fuel_file}
	EOS
	not_if { File.exists? "/var/www/#{fuel_name}" }
end
link "/var/www/#{fuel}" do
	to "/var/www/#{fuel_name}"
	not_if { File.exists? "/var/www/#{fuel}" }
end
