#!/bin/bash

OLD_IP=$1 
NEW_IP=$2

echo "==== Modifying All config maps for Kubernetes ===="

namespaces=$(kubectl get ns | \
  awk '{print $1}' | \
  cut -d '/' -f 2)

for ns in $namespaces; do

    # find all the config map names
    configmaps=$(kubectl -n $ns get cm -o name | \
    awk '{print $1}' | \
    cut -d '/' -f 2)

    # fetch all for filename reference
    dir=$(mktemp -d)
    for cf in $configmaps; do
    kubectl -n $ns get cm $cf -o yaml > $dir/$cf.yaml
    done

    # have grep help you find the files to edit, and where
    grep -Hn $dir/* -e $OLD_IP
    find $dir/ -type f -name "*.yaml" -print0 | xargs -0 sed -i "s/$OLD_IP/$NEW_IP/g"

    for filename in $dir/*.yaml; do
        kubectl apply -f $filename
    done

done

echo "==== Config map modification completed ===="