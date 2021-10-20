#!/bin/bash -eu

yum-config-manager --disable lsrepo
yum clean all --disablerepo='*' --enablerepo=lsrepo
yum repolist