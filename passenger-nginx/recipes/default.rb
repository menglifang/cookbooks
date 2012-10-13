#
# Cookbook Name:: passenger-nginx
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'ruby'

package 'libcurl4-openssl-dev'

run_as = node['rvm']['global'] ? 'root' : node.current_user

bash 'install passenger' do
  code <<-EOH
    source #{node['rvm']['global'] ? '/usr/local/rvm' : "/home/#{node.current_user}/.rvm"}/scripts/rvm
    gem install passenger --no-rdoc --no-ri
  EOH
  user run_as
  notifies :run, "bash[install nginx with passenger module]"
end

bash 'install nginx with passenger module' do
  code <<-EOH
    source #{node['rvm']['global'] ? '/usr/local/rvm' : "/home/#{node.current_user}/.rvm"}/scripts/rvm
    passenger-install-nginx-module --auto --prefix=/usr/local/nginx --auto-download
  EOH
  user 'root'
  action :nothing
end

template "/etc/init.d/nginx" do
  source "nginx"
  owner 'root'
  group 'root'
  action :create_if_missing
end

bash 'update-rc.d' do
  code <<-EOH
    update-rc.d nginx defaults
  EOH

  user 'root'
  not_if { File.exists?("/etc/rc0.d/K20nginx") }
end
