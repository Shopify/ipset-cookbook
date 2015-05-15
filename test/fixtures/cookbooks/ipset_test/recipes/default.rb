ipset 'some-hosts' do
  type 'hash:ip'
  options netmask: 32, maxelem: 512, timeout: 86_400
  action :create
  entries(
    '127.0.0.1' => {
      comment: 'local-host'
    },

    '127.0.0.2' => {
      comment: 'other-local',
      timeout: 43_200
    }
  )
end

ipset 'some-nets' do
  type 'hash:net'
  action :create
  entries(
    '127.1.0.0/16' => {
      comment: 'local-net',
      nomatch: true
    },

    '127.2.0.0/16' => {
      comment: 'other-net',
      nomatch: false
    }
  )
end

ipset 'custom-set' do
  source 'my_set.erb'
  cookbook 'ipset_test'
  options maxelem: 4096
  action :create
end
