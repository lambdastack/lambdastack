#!/bin/bash

# solution from https://github.com/kubernetes/kubeadm/issues/338

OLD_IP=$1 
NEW_IP=$2

if [ -z "$3" ]
then
  echo "Starting IP Change for Kubernetes"
  ./0_delete_nodes.sh $OLD_IP $NEW_IP
  ./1_modify_config_maps.sh $OLD_IP $NEW_IP
  sudo ./2_replace_k8s_configs.sh $OLD_IP $NEW_IP
  sudo ./3_update_hosts.sh $OLD_IP $NEW_IP
else
  sudo ./4_regenerate_certificates.sh
  sudo ./5_get_new_join_credentials.sh $OLD_IP $NEW_IP
fi
