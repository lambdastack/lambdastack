#!/bin/bash

OLD_IP=$1 
NEW_IP=$2

echo "==== Modifying Kubernetes manifests ===="

find /etc/kubernetes/ -type f | xargs grep $OLD_IP

find /etc/kubernetes/ -type f | xargs sed -i "s/$OLD_IP/$NEW_IP/g"

find /etc/kubernetes/ -type f | xargs grep $NEW_IP

echo "==== Kubernetes manifests modification completed ===="
