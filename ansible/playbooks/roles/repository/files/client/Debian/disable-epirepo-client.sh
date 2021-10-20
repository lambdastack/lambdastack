#!/bin/bash -eu

rm -f /etc/apt/sources.list.d/lsrepo.list
apt-get clean
apt update