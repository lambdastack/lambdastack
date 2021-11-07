# LambdaStack
[![GitHub release](https://img.shields.io/github/v/release/lambdastack/LambdaStack.svg)](https://github.com/lambdastack/lambdastack/releases)
[![Github license](https://img.shields.io/github/license/lambdastack/LambdaStack)](https://github.com/lambdastack/lambdastack/releases)

## Note

> Ubuntu has released an updated LTS version - 20.04.03. Testing is in place for this release and once certified, it will become the default standard. Upgrading to this release is documented by Ubuntu but we will have an upgrade option here as well.

## Overview

IMPORTANT - The latest version of LambdaStack is based on Epiphany, which I created in 2018, and being used by high-profile industries that require cross platform scalability and resiliency. There are a few areas and diagrams using the text Epiphany instead of LambdaStack for backwards compatibility (note - any broken links or diagrams due to this fork will be corrected). Going forward, LambdaStack will be addressing many industries and not just industrial Energy. Actually, LFEnergy (Linux Foundation Energy) should look at [Epiphany](https://github.com/epiphany-platform/epiphany) as their standard going forward. The team I created at Hitachi Energy for Epiphany is very good.

LambdaStack at its core is a full automation of Kubernetes and Docker plus additional builtin services/components like:

- Kafka or RabbitMQ for high speed messaging/events
- Prometheus and Alertmanager for monitoring with Graphana for visualization
- Elasticsearch and Kibana for centralized logging (OpenDistro)
- HAProxy for loadbalancing
- Postgres and Elasticsearch for data storage
- KeyCloak for authentication
- Vault (MVP) for protecting secrets and other sensitive data
- Helm as package manager for Kubernetes

The following target platforms are available: AWS, Azure and on-prem installation.

LambdaStack can run on as few as one node (laptop, desktop, server) but the real value comes from running 3 or more nodes for scale and HA. Everything is data driven so simply changing the manifest data and running the automation will modify the environment.
Kubernetes hosts (masters, nodes) and component VMs can be added depending on data in the initial manifest. More information [here](https://github.com/lambdastack/lambdastack/blob/master/docs/home/howto/CLUSTER.md#how-to-scale-or-cluster-components).

Please note that currently LambdaStack supports only creating new masters and nodes and adding them to the Kubernetes cluster. It doesn't support downscale. To remove them from Kubernetes cluster you have to do it manually.

We currently use Terraform and Ansible for our automation orchestration. All automation is idempotent so you can run it as many times as you wish and it will maintain the same state unless you change the data. If someone makes a "snow flake" change to the environment (you should never do this) then simply running the automation again will put the environment back to the desired state.

## Note about documentation

- The documentation is a moving target. Always check the latest documentation on the develop branch. There is a big chance that whatever you are looking for is already added/updated or improved there.

## Quickstart

### LambdaStack

Use the following command to see a full run-down of all commands and flags: (need to launch the LambdaStack docker image - it will drop you into the 'shared' `$PWD` directory and you can then call `lambdastack` like below)

>Make sure you have docker installed and running first!
>Create and change to any directory you want to put your yaml configs and keys (this is the data that will be used to create your clusters on a given cloud). Then pull the image from the hub.docker.com public registry. Once downloaded to your local docker registry then run it with `docker run...` below.

```shell
mkdir <create whatever directory you want>
cd /<to the directory you just created>
docker pull lambdastack/lambdastack:latest
```

```shell
docker run -it -v $PWD:/shared --rm lambdastack/lambdastack:latest
```
>Note - `$PWD` means whatever directory you may be in. Once you're done simply type `exit` and it will exit the docker image. The data will be left in a `build` directory inside of the directory you created and used. Now, you're ready to launch `lambdastack` since you are now at the LambdaStack container command prompt.

```shell
lambdastack --help
```

Generate a new minimum cluster definition:

```shell
lambdastack init -p aws -n demo
```

This minimum file definition is fine to start with, if you need more control over the infrastructure created you can also create a full definition:

```shell
lambdastack init -p aws -n demo --full
```

You will need to modify a few values (like your AWS secrets, SSH keys) in the `demo.yml` file that was created with the `init` command. The default path for the data is based on the `-n` parameter. In this example it is `demo` which means the data to create the cluster would be found:

>When you add the `--full` option LambdaStack will prepend 'full' to the name you pass (e.g., `fulldemo`)

```shell
<whatever base directory you created above>/build/demo/demo.yml
<whatever base directory you created above>/build/demo/keys/ssh/<whatever `key_path` (private ssh key name) value in the `admin_user` section>

#OR when you use --full option

<whatever base directory you created above>/build/fulldemo/fulldemo.yml
<whatever base directory you created above>/build/fulldemo/keys/ssh/<whatever `key_path` (private ssh key name) value in the `admin_user` section>
```

Once you are done with `demo.yml` you can start the cluster deployment by executing:

```shell
lambdastack apply -f demo.yml
```

You will be asked for a password that will be used for encryption of some of build artifacts. More information [here](docs/home/howto/SECURITY.md#how-to-run-lambdastack-with-password)

The build process can take awhile (up to an hour+ depending on options and cloud provider). Let it run and complete. Once complete you will now have a full environment ready to test out. Before moving to a production system, make sure to follow the security guidelines in the docs.

Since version 0.7, lambdastack has an option to backup/recovery some of its components. More information [here](https://github.com/lambdastack/lambdastack/blob/master/docs/home/howto/BACKUP.md). This is an `option` for testing but you will want to do this for any staging or production like environments.

```shell
lambdastack backup -f <file.yml> -b <build_folder>
lambdastack recovery -f <file.yml> -b <build_folder>
```

To delete all deployed components, the following command should be used

```shell
lambdastack delete -b <build_folder>
```

Find more information using table of contents below - especially the [How-to guides](docs/home/HOWTO.md).

## Documentation

<!-- TOC -->

- LambdaStack
  - [Resources](docs/home/RESOURCES.md)
  - [How-to guides](docs/home/HOWTO.md)
  - [Components](docs/home/COMPONENTS.md)
  - [Security](docs/home/SECURITY.md)
  - [Troubleshooting](docs/home/TROUBLESHOOTING.md)
  - [Kubernetes](docs/home/howto/KUBERNETES.md)
  - [Changelog](CHANGELOG.md)
  - [Release policy and lifecycle](docs/home/LIFECYCLE.md)
- Architecture
  - [Logical View](docs/architecture/logical-view.md)
  - [Process View](docs/architecture/process-view.md)
  - [Physical View](docs/architecture/physical-view.md)
- Contributing
  - [Governance model](docs/home/GOVERNANCE.md)
  - [Development environment](docs/home/DEVELOPMENT.md)
  - [Git Workflow](docs/home/GITWORKFLOW.md)

<!-- TOC -->
