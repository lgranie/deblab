#!/bin/sh
      
if [ "$IFACE" = "lanbr0" ]; then
    # Setup lanbr0
    ip addr add 10.10.10.100/24 dev lanbr0

    # Setup veth1 ( link to wan )
    ip link set wan-veth1 master lanbr0
    ip link set dev wan-veth1 up

    # Setup lan routes
    ip route del default
    ip route add default via 10.10.10.1
    # ip route del 10.10.10.0/24
    # ip route add 10.10.10.0/24 via 10.10.10.100 dev lanbr0
fi