# Repository

## Introduction

When installing a cluster LambdaStack sets up its own internal repository for serving:

- OS packages
- Files
- Docker images

This document will provide information about the repository lifecyle and how to deal with possible issues that might popup during that.

## Repository steps and lifecycle

Below the lifecycle of the LambdaStack repository:

1. Download requirements (This can be automatic for [online cluster](./CLUSTER.md#how-to-create-an-LambdaStack-cluster-on-existing-infrastructure) or manual for an [airgapped cluster](./CLUSTER.md#how-to-create-an-LambdaStack-cluster-on-existing-air-gapped-infrastructure). )
2. Set up LambdaStack repository (create `lsrepo` and start HTTP server)
3. For all cluster machines:
   - Back up and disable system package repositories
   - Enable the LambdaStack repository
4. Install LambdaStack components
5. For all cluster machines:
   - Disable the LambdaStack repository
   - Restore original package repositories from the backup
6. Stop LambdaStack repository (optionally removing data)

## Troubleshooting

### Downloading requirements progression and logging

*Note: This will only cover [online clusters](./CLUSTER.md#how-to-create-an-LambdaStack-cluster-on-existing-infrastructure)*

Downloading requirements is one of the most sensitive steps in deploying a new cluster because lots of resources are being downloaded from various sources.

When you see the following output from lscli, requirements are being downloaded:

```shell
INFO cli.engine.ansible.AnsibleCommand - TASK [repository : Run download-requirements script, this can take a long time
INFO cli.engine.ansible.AnsibleCommand - You can check progress on repository host with: journalctl -f -t download-requirements.sh] ***
```

As noted this process can take a long time depending on the connection and as downloading requirements is being done by a shell script, the ```Ansible``` process cannot return any realtime information.

To view the progress during the downloading (realtime output from the logs), one can SSH into the repository machine and run:

```shell
journalctl -f -t download-requirements.sh
```

If for some reason the download-requirements fails you can also always check the log afterwards on the repository machine here:

```shell
/tmp/ls-download-requirements/log
```

### Re-downloading requirements

If for some reason the download requirement step fails and you want to restart, it might be a good idea to delete the following directory first:

```shell
/var/www/html/lsrepo
```

This directory holds all the files being downloaded and removing it makes sure that there are no corrupted or temporary files which might interfere with the restarted download process.

If you want to re-download the requirements but the process finished successfully before, you might need to remove the following file:

```shell
/tmp/ls-download-requirements/download-requirements-done.flag
```

When this file is present and it isn't older than defined amount of time (2 hours by default), it enforces skipping re-downloading requirements.

### Restoring system repositories

If during the component installation an issue will arise (e.g. network issue), it might be the case that the cluster machines are left in a state where step 5 of the repository lifecycle is not run. This might leave the machines with a broken repository setup making re-running ```lscli apply``` impossible as noted in issue [#2324](https://github.com/lambdastack/lambdastack/issues/2324).

To restore the original repository setup on a machine, you can execute the following scripts:

```shell
# Re-enable system repositories
/tmp/ls-repository-setup-scripts/enable-system-repos.sh
# Disable lsrepo
/tmp/ls-repository-setup-scripts/disable-lsrepo-client.sh
```
