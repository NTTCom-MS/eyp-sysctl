if File.exists?('/proc/sys/net/bridge') then
  Facter.add('eyp_sysctl_net_bridge') do
    setcode do
      "true"
    end
  end
end
