#! /bin/bash

IP=$1
MAC=$2
NAME=$3

echo 
echo host $NAME {
echo '    option host-name "'$NAME'";'
echo '    hardware ethernet '$MAC';'
echo '    fixed-address '$IP';'
echo }
