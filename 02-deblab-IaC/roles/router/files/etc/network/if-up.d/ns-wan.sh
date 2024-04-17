#!/bin/sh

# Attach wan-veth0 to wan
ip netns exec wan ip addr add 10.10.10.1/24 dev wan-veth0
ip netns exec wan ip link set dev wan-veth0 up

# Optain Public IP via dhcp
ip link set enp5s0 netns wan
ip netns exec wan dhclient -nw -v -i enp5s0
sleep 10

# Simple firewall / nat rules
ip netns exec wan sysctl -q -w net.ipv4.ip_forward=1
# ip netns exec wan sysctl -q -w net.ipv4.conf.all.rp_filter=0
# ip netns exec wan sysctl -q -w net.ipv4.conf.enp5s0.forwarding=1

# Clean iptables
ip netns exec wan iptables --flush
ip netns exec wan iptables --delete-chain
ip netns exec wan iptables --table nat --flush
ip netns exec wan iptables --table nat --delete-chain

# DROP everything else
ip netns exec wan iptables -P INPUT   DROP
ip netns exec wan iptables -P FORWARD DROP
ip netns exec wan iptables -P OUTPUT  DROP

# Allow dhcp client request
ip netns exec wan iptables -A OUTPUT -p udp -o enp5s0 --match multiport --dports 67,68 -m conntrack --ctstate NEW,ESTABLISHED     -j ACCEPT
ip netns exec wan iptables -A INPUT  -p udp -i enp5s0 --match multiport --dports 67,68 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Masquerade lan to outside & forward
ip netns exec wan iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o enp5s0 -j MASQUERADE
ip netns exec wan iptables -A FORWARD -i wan-veth0 -o enp5s0     -m conntrack --ctstate NEW,ESTABLISHED     -j ACCEPT
ip netns exec wan iptables -A FORWARD -i enp5s0    -o wan-veth0  -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT