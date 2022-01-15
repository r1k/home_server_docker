#!/bin/sh

if [ ! $(docker network ls -q -f name=reverse-proxy) ]; then
  docker network create --driver bridge reverse-proxy
fi

if [ ! $(docker network ls -q -f name=macvlan_net) ]; then
  sudo ip link set dev enp37s0 promisc on
  # create docker network 
  # 192.168.221.16 - 192.168.221.31 where 192.168.221.31 will be the host bridge
  docker network create --driver macvlan --subnet 192.168.221.0/24 --gateway 192.168.221.254 --ip-range 192.168.221.16/28 --aux-address 'host=192.168.221.31' -o parent=enp37s0 macvlan_net

  # now setup the host bridge to be able to reach the addresses on the above network
  sudo ip link add macvlan_shim link enp37s0 type macvlan mode bridge
  # give the host an address on this interface
  sudo ip addr add 192.168.221.31/32 dev macvlan_shim
  # bring up the link
  sudo ip link set macvlan_shim up
  # add routing to be able to get here
  sudo ip route add 192.168.221.16/28 dev macvlan_shim
fi
