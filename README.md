# Description

**WARNING** This is a work-in-progress, and is pretty broken in terms
of updating sets currently.  A fixed 1.0 version is coming soon.

Installs and configures [ipset](http://ipset.netfilter.org/) on
Linux.  Based on the `iptables` cookbook from Opscode.


## Supported Platforms

Debian / Ubuntu only at the moment.


## Usage

Include `ipset` in your node's `run_list` to ensure `ipset` is
installed and the `rebuild-ipset` script is on the system.  The
`ipset` LWRP will then be available:

```ruby
ipset "some-nets" do
  type "hash:net"
  action :create
  entries(
    "127.1.0.0/16" => {
      comment: "local-net",
      nomatch: true,
    },

    "127.2.0.0/16" => {
      comment: "other-net",
      nomatch: false,
    },
  )
end

ipset 'custom-set' do
  source 'my_set.erb'
  cookbook 'ipset_test'
  options maxelem: 4096
  action :create
end
```
