#
# Cookbook Name:: ipset
# Provider:: default
#
# Copyright (C) 2015 Brad Ison
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

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  execute 'rebuild-ipset' do
    command '/usr/sbin/rebuild-ipset'
    action :nothing
  end

  template "/etc/ipset/sets.d/#{new_resource.name}" do
    source new_resource.source || 'set.erb'
    cookbook new_resource.cookbook || 'ipset'
    helpers ::Ipset::TemplateHelpers
    variables(
      name:    new_resource.name,
      type:    new_resource.type,
      options: new_resource.options,
      entries: new_resource.entries
    )
    mode '0644'
    backup false
    notifies :run, 'execute[rebuild-ipset]'
  end
end

action :remove do
  execute 'rebuild-ipset' do
    command '/usr/sbin/rebuild-ipset'
    action :nothing
  end

  file "/etc/ipset/sets.d/#{new_resource.name}" do
    action :delete
    backup false
    notifies :run, 'execute[rebuild-ipset]'
  end
end
