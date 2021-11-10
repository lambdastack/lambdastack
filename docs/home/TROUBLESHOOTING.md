# Troubleshooting

# Kubernetes

>Keep in mind, this is not really an issue but a default security feature! However, it is listed here and in [Security](./howto/SECURITY.md) as well. If you want even more information then see `kubeconfig` files section in the [Kubernetes Documents](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/).

After the initial install and setup of Kubernetes and you see something like the following when you run any `kubectl ...` command:

```shell
$ kubectl cluster-info   #Note: could be any command and not just cluster-info
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```

It most likely is related to `/etc/kubernetes/admin.conf` and `kubectl` can't locate it. There are multiple ways to resolve this:

Option 1:

If you are running as `root` or using `sudo` in front of your kubectl call the following will work fine.

```shell
export KUBECONFIG=/etc/kubernetes/admin.conf
# Note: you can add this to your .bash_profile so that it is always exported
```
Option 2: 

If you are running as any other user (e.g., ubuntu, operations, etc.) and you do not want to `sudo` then do something like the following:

```shell
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Now you can run `kubectl` without using `sudo`. You can automate this to your liking for the users you wish to allow access to `kubectl`.

Option 3: (Don't want to `export KUBECONFIG=...`) - **Default for LambdaStack Security**

Always use `kubeconfig=/etc/kubernetes/admin.conf` as a parameter on `kubectl` but this option will require `sudo` or `root`. If you do not want to `export KUBECONFIG=...` nor `sudo` and not `root` then you can do Option 2 above less the `export ...` command and instead add `kubeconfig=$HOME/.kubernetes/admin.conf` as a parameter to `kubectl`.

You can see [Security](./howto/SECURITY.md) for more information.

## Kubernetes Master

## Unhealthy - connection refused

>Deprecated in releases after 1.16.x. --port=0 should remain and `kubectl get cs` has been deprecated. You can use `kubectl get nodes -o wide` to get a status of all nodes including master/control-plane.

If you see something like the following after checking the status of components:

```shell
scheduler            Unhealthy   Get "http://127.0.0.1:10251/healthz": dial tcp 127.0.0.1:10251: connect: connection refused
controller-manager   Unhealthy   Get "http://127.0.0.1:10252/healthz": dial tcp 127.0.0.1:10252: connect: connection refused
```

Modify the following files on **all master nodes**:

```shell
$ sudo vim /etc/kubernetes/manifests/kube-scheduler.yaml
Comment out or Clear the line (spec->containers->command) containing this phrase: - --port=0

$ sudo vim /etc/kubernetes/manifests/kube-controller-manager.yaml
Comment out or Clear the line (spec->containers->command) containing this phrase: - --port=0

$ sudo systemctl restart kubelet.service
```

You should see `Healthy` STATUS for controller-manager and scheduler.

>Note: The --port parameter is deprecated in the latest K8s release. See https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/

## Another reason for this problem

You may have used http_proxy in the docker setting. In this case, you must set address of the master nodes addresses in no_proxy.

# LambdaStack container connection issues after hibernation/sleep on Windows

When running the LambdaStack container on Windows you might get such errors when trying to run the apply command:

Azure:
```shell
INFO cli.engine.terraform.TerraformCommand - Error: Error reading queue properties for AzureRM Storage Account "cluster": queues.Client#GetServiceProperties: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: error response cannot be parsed: "\ufeff<?xml version=\"1.0\" encoding=\"utf-8\"?><Error><Code>AuthenticationFailed</Code><Message>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.\nRequestId:cba2935f-1003-006f-071d-db55f6000000\nTime:2020-02-04T05:38:45.4268197Z</Message><AuthenticationErrorDetail>Request date header too old: 'Fri, 31 Jan 2020 12:28:37 GMT'</AuthenticationErrorDetail></Error>" error: invalid character 'ï' looking for beginning of value
```

AWS:
```shell
ERROR lambdastack - An error occurred (AuthFailure) when calling the DescribeImages operation: AWS was not able to validate the provided access credentials
```

These issues might occur when the host machine you are running the LambdaStack container on was put to sleep or hybernated for an extended period of time. Hyper-V might have issues syncing the time between the container and the host after it wakes up or is resumed. You can confirm this by checking the date and time in your container by running:

```shell
Date
```

If the times are out of sync restarting the container will resolve the issue. If you do not want to restart the container you can also run the following 2 commands from an elevated Powershell prompt to force it during container runtime:

```shell
Get-VMIntegrationService -VMName DockerDesktopVM -Name "Time Synchronization" | Disable-VMIntegrationService

Get-VMIntegrationService -VMName DockerDesktopVM -Name "Time Synchronization" | Enable-VMIntegrationService
```

Common:

When public key is created by `ssh-keygen` sometimes it's necessary to convert it to utf-8 encoding.
Otherwise such error occurs:

```text
ERROR lambdastack - 'utf-8' codec can't decode byte 0xff in position 0: invalid start byte
```

# Kafka

When running the Ansible automation there is a verification script called `kafka_producer_consumer.py` which creates a topic, produces messages and consumes messages. If the script fails for whatever reason then Ansible verification will report it as an error. An example of an issue is as follows:

```text
ERROR org.apache.kafka.common.errors.InvalidReplicationFactorException: Replication factor: 1 larger than available brokers: 0.
```

This issue is saying the a replication of 1 is being attempted but there are no brokers '0'. This means that the kafka broker(s) are not running any longer. Kafka will start and attempt to establish connections etc. and if unable it will shutdown and log the message. So, when the verification script runs it will not be able to find a local broker (runs on each broker).

Take a look at syslog/dmesg and run `sudo systemctl status kafka`. Most likely it is related to security (TLS/SSL) and/or network but it can also be incorrect settings in the config file `/opt/kafka/config/server.properties`. Correct and rerun the automation.
