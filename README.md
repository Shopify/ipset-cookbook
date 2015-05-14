# Description

Installs and configures [ipset](http://ipset.netfilter.org/) on
Linux.  Based on the `iptables` cookbook from Opscode.


## Supported Platforms

Debian / Ubuntu only at the moment.


## Usage

Include `ipset` in your node's `run_list` to ensure `ipset` is
installed and `rebuild-ipset` script is on the system.  The `ipset`
and `ipset_entry` LWRPs will then be available:

```ruby
ipset "some-hosts" do
  type "hash:ip"
  options netmask: 30, maxelem: 512, timeout: 86400
  action :create
end

ipset_entry "local-host" do
  set "some-hosts"
  entry "127.0.0.2"
  options nomatch: false, timeout: 43200
end
```
