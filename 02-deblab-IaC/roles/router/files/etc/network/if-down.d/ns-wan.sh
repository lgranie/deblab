#!/bin/sh

# Init netns wan
if [ ! -f /run/netns/wan ]; then
    ip netns delete wan
fi
