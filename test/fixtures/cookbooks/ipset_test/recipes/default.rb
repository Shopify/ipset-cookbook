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

ipset "some-nets" do
  type "hash:net"
  action :create
end

ipset_entry "local-net" do
  set "some-nets"
  entry "127.0.0.0/8"
  options nomatch: true
end
