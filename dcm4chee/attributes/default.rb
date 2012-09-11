# Cookbook Name:: dcm4chee
# Attributes:: default
#
# #
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

default['dcm4chee']['home'] = '/opt/dcm4chee-2.17.2-mysql'
default['dcm4chee']['archive'] = 'dcm4chee-2.17.2-mysql.zip'
default['dcm4chee']['version'] = '2.17.2'
default['dcm4chee']['database'] = 'mysql'
default['dcm4chee']['url'] = 'http://cdnetworks-kr-2.dl.sourceforge.net/project/dcm4che/dcm4chee/2.17.2/dcm4chee-2.17.2-mysql.zip'

default['dcm4chee']['jboss']['home'] = '/opt/jboss-4.2.3.GA'
default['dcm4chee']['jboss']['archive'] = 'jboss-4.2.3.GA.zip'
default['dcm4chee']['jboss']['version'] = '4.2.3.GA'
default['dcm4chee']['jboss']['url'] = 'http://superb-sea2.dl.sourceforge.net/project/jboss/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA.zip'

default['mysql']['server_root_password'] = '123456'
default['mysql']['server_repl_password'] = '123456'
default['mysql']['server_debian_password'] = '123456'
