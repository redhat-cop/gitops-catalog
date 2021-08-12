# OpenShift Logging infrastructure

Installs the Logging infrastructure.

## Prerequisites

First, install the following operators in your cluster:

- [Openshift Elasticsearch Operator](../../elasticsearch-operator)

Do not use the `base` directory directly, as you will need to patch 
* the `ClusterLogging` instance `storageClassName`
* the `ConsoleLink`

The current *overlays* available are:
* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Logging infrastructure by running from the root `gitops-catalog` directory

```
oc apply -k openshift-logging/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-logging/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-logging/instance/overlays/default?ref=main
```