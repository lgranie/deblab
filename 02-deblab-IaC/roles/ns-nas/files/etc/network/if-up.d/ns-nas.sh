#!/bin/sh

# Attach nas-veth0 to nas
ip netns exec nas ip addr add 10.10.10.2/24 dev nas-veth0
ip netns exec nas ip link set dev nas-veth0 up
