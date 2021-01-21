#! /bin/bash

sudo ip link set dev enp37s0 promisc on

docker network create -d macvlan --subnet 192.168.221.0/24 --gateway 192.168.221.254 --ip-range 192.168.221.32/31 --aux-address 'host=192.168.221.33' -o parent=enp37s0 tvheadend_net

sudo ip link add tvheadend_shim link enp37s0 type macvlan mode bridge

sudo ip addr add 192.168.221.33/32 dev tvheadend_shim

sudo ip link set tvheadend_shim up

sudo ip route add 192.168.221.32/31 dev tvheadend_shim
