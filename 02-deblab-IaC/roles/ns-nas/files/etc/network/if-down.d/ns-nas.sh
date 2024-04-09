#!/bin/sh

# Init netns wan
if [ ! -f /run/netns/nas ]; then
    ip netns delete nas
fi
