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
  execute "rebuild-ipset" do
    command "/usr/sbin/rebuild-ipset"
    action :nothing
  end

  directory "/etc/ipset/sets.d/#{new_resource.name}.d"

  t = template "/etc/ipset/sets.d/#{new_resource.name}" do
    source "set.erb"
    cookbook "ipset"
    mode "0644"
    helpers ::Ipset::TemplateHelpers
    variables(
      :name => new_resource.name,
      :type => new_resource.type,
      :options => new_resource.options
    )
    backup false
    notifies :run, resources(:execute => "rebuild-ipset")
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :remove do
  execute "rebuild-ipset" do
    command "/usr/sbin/rebuild-ipset"
    action :nothing
  end

  f = file "/etc/ipset/sets.d/#{new_resource.name}" do
    action :delete
    backup false
    notifies :run, resources(:execute => "rebuild-ipset")
  end

  directory "/etc/ipset/sets.d/#{new_resource.name}.d" do
    action :delete
  end

  new_resource.updated_by_last_action(f.updated_by_last_action?)
end
