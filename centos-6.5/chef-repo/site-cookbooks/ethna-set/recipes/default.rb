#
# Cookbook Name:: pear-ethna
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ethna_name = 'ethna'
ethna_ver = '2.6.0beta3'
ethna_unzip = ethna_name + '-' + ethna_ver
ethna_pkg = ethna_unzip + '.tar.gz'
ethna_src_url = 'https://github.com/ethna/ethna/archive/' + ethna_ver + '.tar.gz'

package 'wget' do
	action :install
	not_if 'rpm -qa | grep wget'
end

bash 'install pear ethna' do
	cwd '/usr/share/pear'
	code <<-EOS
		# pear channel-update pear.php.net
		# pear upgrade pear
		# pear channel-discover pear.ethna.jp
		# pear install ethna/ethna
		wget -O/usr/local/src/#{ethna_pkg} #{ethna_src_url}
		tar xzpvf /usr/local/src/#{ethna_pkg}
	EOS
	not_if { File.exists? "/usr/share/pear/#{ethna_unzip}" }
end

link "/usr/share/pear/#{ethna_name}" do
	to "/usr/share/pear/#{ethna_unzip}"
	not_if { File.exists? "/usr/share/pear/#{ethna_name}" }
end


