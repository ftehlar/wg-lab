#!/usr/bin/bash

if [ "$1" == "clean" ]; then
    sudo ip netns del wgns
    sudo ip link del vpp1

    exit 0
fi

sudo ip netns add wgns
sudo ip link add veth_vpp1 type veth peer name vpp1
sudo ip link set dev vpp1 up
sudo ip link set dev veth_vpp1 up netns wgns

sudo ip -n wgns addr add 192.10.0.2/24 dev veth_vpp1

sudo ip netns exec wgns wg-quick up ./wg0.conf
sudo ip -n wgns route add 10.0.0.1/32 dev wg0

