# Examples

The full documentation for the examples is located at [Examples](https://www.lambdastackio.com/docs/examples). The basic information for Applications and Clusters is listed in this readme.

## Applications

All of the applications show how to take websites or microservices and build Helm Charts. These Helm Charts are then used to deploy the given application(s) to a given cluster.

## Clusters

LambdaStack is a fully automated Kubernetes build and deployment platform. It also provides all of the core items required by development to build full microservices based environments. For example, by default, LambdaStack installs and configures Kafka, Postgres, Open Distro (Open Source version of Elastic Search), HAProxy, Apache Ignite, and more. The primary objective is to abstract the difficulties of Kubernetes/Container Orchestration from the development teams so that they focus on their domain specific areas.

### AWS (Amazon Web Services)

Basic requirements:
- AWS account
- AWS Key and Secret - These should be saved somewhere secure. The Secret value will only be shown once or downloaded once. Also, make sure you do not hardcode the values in code since you don't want to distribute the values in your source control (e.g., GitHub)
- SSH public and private keys. Most likely you already have these. If not then creating them from your OS is simple enough. The documentation goes into more detail on this
- Docker - Docker needs to be install and running since LambdaStack uses containers so you don't have to build out LambdaStack itself - good thing :)
- (Optional) Clone the LambdaStack repo on GitHub. It is not required to clone or have the LambdaStack source code. Since we use Docker containers all you need to do is do a `docker run ...`. If the LambdaStack container is not already downloaded then the first time you call `docker run ...` it will download it and then launch it. It may take a few minutes to download on the first run but after that it will launch locally (if you needed or wanted to run it again)

#### EKS

This is not the default option. When we first built LambdaStack a number of cloud vendors had not fully built out their managed Kubernetes clusters. In addition, the different environments were more restrictive which was fine for a small team that would ever only use one cloud provider - ever. For example, managed Kubernetes clusters run older versions of Kubernetes. This makes sense from a cross training and standardization plan for the given cloud provider's personnell. However, this can pose an issue if your developers or operation teams need a feature from the latest Kubernetes release. Another thing to be aware of is, you have no control over the Control Plane. This is managed for you and thus you are unable to enhance or add needed value. This is also known as the API Server(s).

Again, if you have a small team that may not have all of the skills needed to operate a Kubernetes cluster then this may be a good option. It's sometimes easy to use it to spin up for testing new development features.

**Good News** - LambdaStack supports both IaaS and Cloud Managed versions of Kubernetes!

#### IaaS

The default is to build out an IaaS environment where you will manage your own Kubernetes cluster and supporting services to support your microservices. This gives you the most flexibility and control and recommended if doing a `multicloud` deployment model. There are too many differences between the major cloud vendor's managed Kubernetes clusters to standardize so that your operation team(s) can more easily manage the environments.

### Azure

Basic requirements:
- Azure account
- User ID/Password or Service Principal

#### AKS

This is not the default option. When we first built LambdaStack a number of cloud vendors had not fully built out their managed Kubernetes clusters. In addition, the different environments were more restrictive which was fine for a small team that would ever only use one cloud provider - ever. For example, managed Kubernetes clusters run older versions of Kubernetes. This makes sense from a cross training and standardization plan for the given cloud provider's personnell. However, this can pose an issue if your developers or operation teams need a feature from the latest Kubernetes release. Another thing to be aware of is, you have no control over the Control Plane. This is managed for you and thus you are unable to enhance or add needed value. This is also known as the API Server(s).

Again, if you have a small team that may not have all of the skills needed to operate a Kubernetes cluster then this may be a good option. It's sometimes easy to use it to spin up for testing new development features.

**Good News** - LambdaStack supports both IaaS and Cloud Managed versions of Kubernetes! 

#### IaaS

The default is to build out an IaaS environment where you will manage your own Kubernetes cluster and supporting services to support your microservices. This gives you the most flexibility and control and recommended if doing a `multicloud` deployment model. There are too many differences between the major cloud vendor's managed Kubernetes clusters to standardize so that your operation team(s) can more easily manage the environments.

### GCP (Google Cloud Platform) - Currently a WIP

Basic requirements:
- Google Cloud Platform account

#### GKE

This is not the default option. When we first built LambdaStack a number of cloud vendors had not fully built out their managed Kubernetes clusters. In addition, the different environments were more restrictive which was fine for a small team that would ever only use one cloud provider - ever. For example, managed Kubernetes clusters run older versions of Kubernetes. This makes sense from a cross training and standardization plan for the given cloud provider's personnell. However, this can pose an issue if your developers or operation teams need a feature from the latest Kubernetes release. Another thing to be aware of is, you have no control over the Control Plane. This is managed for you and thus you are unable to enhance or add needed value. This is also known as the API Server(s).

Again, if you have a small team that may not have all of the skills needed to operate a Kubernetes cluster then this may be a good option. It's sometimes easy to use it to spin up for testing new development features.

**Good News** - LambdaStack supports both IaaS and Cloud Managed versions of Kubernetes! 

#### IaaS

The default is to build out an IaaS environment where you will manage your own Kubernetes cluster and supporting services to support your microservices. This gives you the most flexibility and control and recommended if doing a `multicloud` deployment model. There are too many differences between the major cloud vendor's managed Kubernetes clusters to standardize so that your operation team(s) can more easily manage the environments.

### On-Premise

Only IaaS is an available option for on-premise virtualized environments like VMware, OpenStack or something like Oracle Cloud.
