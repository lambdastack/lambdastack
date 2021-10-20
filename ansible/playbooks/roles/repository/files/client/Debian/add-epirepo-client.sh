#!/bin/bash -eu

REPOSITORY_URL=$1

echo "deb [trusted=yes] $REPOSITORY_URL/packages ./" > /etc/apt/sources.list.d/lsrepo.list

apt update