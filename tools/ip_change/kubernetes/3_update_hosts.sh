#!/bin/bash

OLD_IP=$1 
NEW_IP=$2

echo "==== Modifying /etc/hosts for new IP ===="

sed -i "s/$OLD_IP/$NEW_IP/g" "/etc/hosts"

echo "==== /etc/hosts modification completed ===="
