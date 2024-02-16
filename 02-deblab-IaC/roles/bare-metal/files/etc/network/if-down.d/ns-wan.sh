#!/bin/sh

if [ "$IFACE" = "enp5s0" ]; then
    # Init netns wan
    if [ ! -f /run/netns/wan ]; then
        ip netns delete wan
    fi
fi
