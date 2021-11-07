#!/bin/bash

# IMPORTANT!
# Requires sudo permissions
# Can be executed ONLY after changing IPs - since it will regenerate certificates using current IP address. 

echo "[INFO] This script should be run after changing IP address on the machine"
echo "==== Regenarating Kubernetes certificates with new IP ===="

cd /etc/kubernetes/pki

rm apiserver.crt apiserver.key
kubeadm init phase certs apiserver

rm etcd/peer.crt etcd/peer.key
kubeadm init phase certs etcd-peer
cd -
systemctl restart kubelet
systemctl restart docker

sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config

echo "==== Regenarating Kubernetes certificates completed ===="
