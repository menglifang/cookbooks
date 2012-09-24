#
# Cookbook Name:: moosefs
# Recipe:: master
#
# Copyright 2011-2012, Beijing Menglifang Network Science and Technology
# Co.,Ltd.
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

if platform? 'ubuntu'
  package 'build-essential'
  package 'zlib1g-dev'

  remote_file "#{Chef::Config[:file_cache_path]}/mfs-#{node[:moosefs][:version]}.gz" do
    source "http://dev.menglifang.org/repos/src/moosefs/mfs-#{node[:moosefs][:version]}.gz"
    notifies :run, "bash[install_moosefs]", :immediately
  end

  bash "install_moosefs" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      groupadd mfs
      useradd -g mfs mfs
      tar -zxf mfs-#{node[:moosefs][:version]}.gz
      (cd mfs-#{node[:moosefs][:version]}/ && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs --disable-mfschunkserver --disable-mfsmount && make && make install)

      cd /etc
      cp mfsmaster.cfg.dist mfsmaster.cfg
      cp mfsmetalogger.cfg.dist mfsmetalogger.cfg
      cp mfsexports.cfg.dist mfsexports.cfg

      cd /var/lib/mfs
      cp metadata.mfs.empty metadata.mfs
    EOH
    action :nothing
  end
end
