# Cookbook Name:: dcm4chee
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

include_recipe "java"

if node['dcm4chee']['version'].start_with? '2.17'
  node['dcm4chee']['jboss']['home'] = '/opt/jboss-4.2.3.GA'
  node['dcm4chee']['jboss']['archive'] = 'jboss-4.2.3.GA.zip'
  node['dcm4chee']['jboss']['version'] = '4.2.3.GA'
  node['dcm4chee']['jboss']['url'] = 'http://superb-sea2.dl.sourceforge.net/project/jboss/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA.zip'
end

package 'unzip'

bash "install jboss" do
  code <<-EOH
    cd /tmp
    wget #{node['dcm4chee']['jboss']['url']}

    unzip #{node['dcm4chee']['jboss']['archive']} -d /opt
    rm -f #{node['dcm4chee']['jboss']['archive']}
  EOH
  not_if "test -d #{node['dcm4chee']['jboss']['home']}"
end

bash 'install dcm4chee' do
  code <<-EOH
    cd /tmp
    wget #{node['dcm4chee']['url']}

    unzip #{node['dcm4chee']['archive']} -d /opt 
    rm -f #{node['dcm4chee']['archive']}

    cd #{node['dcm4chee']['home']}
    ./bin/install_jboss.sh #{node['dcm4chee']['jboss']['home']}
  EOH
  not_if "test -d #{node['dcm4chee']['home']}"
end

if node['dcm4chee']['database'] == 'mysql'
  include_recipe "mysql::server"

  mysql_database "create the database" do
    connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
    database_name "pacsdb"
    action [:create]
  end


  mysql_database "grant permissions for pacs" do
    connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
    action :query
    sql "grant all on pacsdb.* to 'pacs'@'localhost' identified by 'pacs'"
  end

  bash 'import the schema' do
    code "mysql -upacs -ppacs pacsdb < #{node['dcm4chee']['home']}/mysql/create.mysql"
  end
end

template  "#{node['dcm4chee']['home']}/server/default/conf/xmdesc/dcm4chee-wado-xmbean.xml" do
  source 'dcm4chee-wado-xmbean.xml'
end

template  "/etc/init.d/dcm4chee" do
  source 'dcm4chee.erb'
  variables(
    'dcm4chee_home' =>  node['dcm4chee']['home'],
    'java_home' => node['java']['java_home']
  )
end

service 'dcm4chee' do
  action [:enable, :start]
end
