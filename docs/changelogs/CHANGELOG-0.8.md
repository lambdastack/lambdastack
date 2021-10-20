# Changelog 0.8

## [0.8.0] 2020-10-22

### Added

- [#1322](https://github.com/lambdastack/lambdastack/issues/1322) - Add proper documentation how to define additional security rules for AWS/Azure
- [#1773](https://github.com/lambdastack/lambdastack/issues/1773) - Document Azure supported images

### Fixed

- [#1754](https://github.com/lambdastack/lambdastack/issues/1754) - Fix Vault installation for setup without K8s
- [#1640](https://github.com/lambdastack/lambdastack/issues/1640) - Default disk size for repository machine increased to 64 GB (AWS and Azure)
- [#1774](https://github.com/lambdastack/lambdastack/issues/1774) - [lscli upgrade] Filebeat stops working when legacy Elasticsearch (v6) is used for storing logs
- [#1775](https://github.com/lambdastack/lambdastack/issues/1775) - [lscli upgrade] Cannot upgrade LambdaStack cluster in version 0.6.x when using "--wait-for-pods" flag.

### Updated

- [#1719](https://github.com/lambdastack/lambdastack/issues/1719) - Upgrade Open Distro for Elasticsearch to v1.10.1 and elasticsearch-oss to v7.9.1

## [0.8.0rc1] 2020-10-08

### Added

- [#1542](https://github.com/lambdastack/lambdastack/issues/1542) - Implement Ansible role postgres-exporter
- [#1302](https://github.com/lambdastack/lambdastack/issues/1302) - Ability to update control plane certificates expiration date
- [#1324](https://github.com/lambdastack/lambdastack/issues/1324) - Added Logstash to export data from Elasticsearch to csv format
- [#1300](https://github.com/lambdastack/lambdastack/issues/1300) - Configure OpenSSH according to Mozilla Infosec guidance
- [#1543](https://github.com/lambdastack/lambdastack/issues/1543) - Add support for Azure availability sets
- [#1609](https://github.com/lambdastack/lambdastack/issues/1609) - Build lscli image using Dockerfile only (without shell script)
- [#765](https://github.com/lambdastack/lambdastack/issues/765) - Added multiline support for logs statements in Filebeat
- [#1618](https://github.com/lambdastack/lambdastack/issues/1618) - Add kubectl and Helm to lscli and devcontainer images
- [#1225](https://github.com/lambdastack/lambdastack/issues/1225) - Add OS_PATCHING.md with information about patching RHEL OS
- [#1656](https://github.com/lambdastack/lambdastack/issues/1656) - Run Helm tasks from LambdaStack container
- [#1640](https://github.com/lambdastack/lambdastack/issues/1640) - Added separate machine for repository and changed helm to use localhost address
- [#1673](https://github.com/lambdastack/lambdastack/issues/1673) - Added Node Exporter as DaemonSet for "Kubernetes as Cloud Service"
- [#1670](https://github.com/lambdastack/lambdastack/issues/1670) - Added Filebeat as DaemonSet for "Kubernetes as Cloud Service"
- [#1696](https://github.com/lambdastack/lambdastack/issues/1696) - Document installation of LambdaStack using AzBI and AzKS modules

### Updated

- [#846](https://github.com/lambdastack/lambdastack/issues/846) - Update Filebeat to v7.8.1
- [#1140](https://github.com/lambdastack/lambdastack/issues/1140) - Upgrade Open Distro for Elasticsearch to v7.8.0
- [#1316](https://github.com/lambdastack/lambdastack/issues/1316) - Upgrade HAProxy to v2.2
- [#1115](https://github.com/lambdastack/lambdastack/issues/1115) - Upgrade Node exporter to v1.0.1
- [#1589](https://github.com/lambdastack/lambdastack/issues/1589) - Update OS_PATCHING.md with information about patching Ubuntu OS
- [#1639](https://github.com/lambdastack/lambdastack/issues/1639) - Use local kubectl in 'prometheus' role
- [#1654](https://github.com/lambdastack/lambdastack/issues/1654) - Use local kubectl for 'applications' part

### Fixed

- Fix for changing Terraform templates between LScli apply runs on Azure.
- [#1520](https://github.com/lambdastack/lambdastack/issues/1520) - Added additional SANs to k8s-apiserver certificates to run kubectl outside the cluster
- [#1491](https://github.com/lambdastack/lambdastack/issues/1491) - Error running upgrade on a 0.3 cluster: missing shared-config
- [#1659](https://github.com/lambdastack/lambdastack/issues/1659) - lscli upgrade fails on Ubuntu on downgrading kubernetes-cni package
- [#1681](https://github.com/lambdastack/lambdastack/issues/1681) - Node exporter does not work after the upgrade
- [#1705](https://github.com/lambdastack/lambdastack/issues/1705) - [RHEL/CentOS] lscli fails on downloading requirements - Docker CE repo not available
- [#922](https://github.com/lambdastack/lambdastack/issues/922) - [RHEL/CentOS] Elasticsearch v6 stops working after lscli upgrade
- [#1741](https://github.com/lambdastack/lambdastack/issues/1741) - Upgrade doesn't work with ERROR lscli - No such attribute: cloud

### Breaking changes

- Repository machine was introduced (ref #1640)
- Change cluster configuration manifest in order to be compatible with changes in #1640 [example] (https://github.com/lambdastack/lambdastack/blob/master/core/src/lscli/data/common/defaults/LambdaStack-cluster.yml)
- Filebeat renamed fields in 7.0, see [here](https://www.elastic.co/guide/en/beats/libbeat/current/breaking-changes-7.0.html#_field_name_changes). The `source` field was removed and replaced with `log.file.path`.

### Known issues

- [1647](https://github.com/lambdastack/lambdastack/issues/1647) - `lscli upgrade` fails on `[opendistro_for_elasticsearch : Provide jvm configuration file]` task
