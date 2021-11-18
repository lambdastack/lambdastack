---
title: "Overview"
linkTitle: "Overview"
weight: 1
description: >
  Find out if LambdaStack is for you!
---

{{% pageinfo %}}
LambdaStack is **NOT** a customized version of Kubernetes! LambdaStack **IS** a complete Kubernetes Automation Platform that also exercises best practices of setting up Kafka, Postgres, RabbitMQ, Elastic Search (Open Distro), HAProxy, Vault, KeyCloak, Apache Ignite, Storage, HA, DR, Multicloud and more.
{{% /pageinfo %}}

## Open Source License

LambdaStack is fully open sourced and uses the Apache-2.0 license so that you may use it as you see fit. By using the Apache-2.0 license, scans such as Blackduck show no issues for Enterprises.

## Automation

LambdaStack uses Terraform, Ansible, Docker, and Python. It's also fully Data Driven. Meaning, all of the data is stored in `YAML` files. It's so dynamic that even some templates are auto-generated based on the `YAML` data files before passing through the automation engines thus allowing your to customize everything without modifying source code!

## How does it differ from others?

Most, if not all, competitors only setup basic automation of Kubernetes. Meaning, they may use `YAML` data files but they:
* Have a number of options that may be hard-coded
* Only install Kubernetes
* Do not install and setup default production like environments
* Do not install and setup Kafka, HAProxy, Postgres, RabbitMQ, KeyCloak, Elastic Search, Apache Ignite, advanced logging, enhanced monitoring and alerting, persistent storage volumes and much more
* Do not build their own repo environment for air-gapped systems (used in highly secured and mission critical areas)
* Cannot run on a single node
* Are not architected for hybrid and multicloud systems
* May not be able to run the same on-premise as in the cloud
* May not be able to build out IaaS and cloud vendor specific managed Kubernetes (e.g., EKS, AKS, GKE)

## Why was LambdaStack created?

Enterprises and Industry are moving toward Digital Transformations but they journey is not simple or fast. There may be many product lines of legacy applications that need to be modernized and/or re-architected to take advantage of the benifits for true Microservices. Also, some industry domains are so specialized that the core group of software engineers are more domain specialist than generalist. 

LambdaStack was architected to remove the burden of:
* Learning how to setup and manage Kubernetes
* Build true Microservices where needed
* Understand high-performing event processing
* Auto-scaling
* Knowing how-to build hybrid clusters
* Knowing how-to build true Multicloud systems
* Knowing how-to build Kubernetes and all of the above in air-gapped environments
* Knowing how-to build hardened secure systems
* Knowing how-to operate the above in production like environments
* A lot more...

Basically, allow the development teams focus on adding business value and increasing time-to-market!

## Next steps

* [Getting Started](/docs/getting-started/): Get started with LambdaStack
* [Examples](/docs/examples/): Check out some examples of building clusters and building applications to be used on the clusters
