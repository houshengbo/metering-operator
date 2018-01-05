# Installing Chargeback

Chargeback consists of a few components:

- A Chargeback pod which aggregates Prometheus data and generates reports based
  on the collected usage information.
- Hive and Presto clusters, used by the Chargeback pod to perform queries on the
  collected usage data.

## Prerequisites

Chargeback requires the following components:

- A Tectonic 1.8 cluster.
- A StorageClass for dynamic volume provisioning. ([See configuring chargeback][configuring-chargeback] for more information.)
- A properly configured kubectl to access the Kubernetes cluster.

## Installation

Use the installation script to install Chargeback. Before running the script, customize the installation to define installation or data storage location.

### Modifying default values

Chargeback will install into an existing namespace. Without configuration, the
default is `chargeback`.

Chargeback also assumes it needs a docker pull secret to pull images, which
defaults to a secret named `coreos-pull-secret` in the `tectonic-system`
namespace.

To change either of these, override the following environment variables:

```
$ export CHARGEBACK_NAMESPACE=chargeback
$ export PULL_SECRET_NAMESPACE=tectonic-system
$ export PULL_SECRET=coreos-pull-secret
```

### Configuration

Before installing, please read [Configuring Chargeback][configuring-chargeback].
Some options may not be changed post-install. Be certain to configure these options, if desired, before installation.

### Run the install script

Chargeback can be installed with the following command:

```
$ ./hack/alm-install.sh
```

### Uninstall

To uninstall Chargeback and its related resources:

```
$ ./hack/alm-uninstall.sh
```

## Verifying operation

Check the logs of the `chargeback` deployment for errors:

```
$ kubectl get pods -n $CHARGEBACK_NAMESPACE -l app=chargeback -o name | cut -d/ -f2 | xargs -I{} kubectl -n $CHARGEBACK_NAMESPACE logs {} -f
```

## Using Chargeback

For instructions on using Chargeback, please see [Using Chargeback][using-chargeback].


[using-chargeback]: using-chargeback.md
[configuring-chargeback]: configuration.md