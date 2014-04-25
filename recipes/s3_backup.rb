# -*- coding: UTF-8 -*-
# Cookbook Name:: common-tools
# Recipe:: s3_backup
#
# Copyright 2014, Craig Tracey <craigtracey@gmail.com>
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

include_recipe 's3cmd::default'

template "/etc/cron.#{node['common-tools']['s3_backup']['frequency']}/s3_backup" do
  source  's3_backup.erb'
  user    'root'
  group   'root'
  mode    '0755'
  variables(
    s3_url: node['common-tools']['s3_backup']['s3_url'],
    backup_name: node['common-tools']['s3_backup']['backup_name'],
    backup_user: node['common-tools']['s3_backup']['backup_user'],
    backup_password: node['common-tools']['s3_backup']['backup_password'],
    backup_databases: node['common-tools']['s3_backup']['backup_databases'],
    backup_directories: node['common-tools']['s3_backup']['backup_directories'],
    backup_days: node['common-tools']['s3_backup']['backup_days']
  )
end

link '/root/.s3cfg' do
  to "#{node['s3cmd']['dir']}/etc/s3cfg"
  user  'root'
  group 'root'
  mode  '0600'
end
