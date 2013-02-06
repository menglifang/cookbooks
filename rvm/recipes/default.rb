#
# Cookbook Name:: rvm
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
#

include_recipe 'apt'
include_recipe 'git'

package 'curl'

rvm_global = node['rvm']['global']
rvm_user = rvm_global ? 'root' : node['rvm']['user']
rvm_dir = rvm_global ? '/usr/local/rvm' : node['rvm']['dir']
rvmrc = rvm_global ? '/etc/rvmrc' : "/home/#{rvm_user}"

template rvmrc do
  source 'rvmrc'
end

bash "install rvm" do
  code <<-EOH
    curl -L https://get.rvm.io | #{rvm_global ? "sudo" : ""} bash -s stable
    source "#{rvm_dir}/scripts/rvm"
  EOH
  user rvm_user
  not_if {File.exists?("#{rvm_dir}/bin/rvm")}
end
