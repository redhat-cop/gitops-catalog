# OpenShift Serverless - Knative Eventing

Installs the `IntegrationPlatform` of the Red Hat Integration - Camel-k Operator.

## Prerequisites

First, install the [Red Hat Integration - Camel-k Operator](../../operator) in your cluster.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the
version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are:

* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install it by running from the
root `gitops-catalog` directory:

```
oc apply -k red-hat-camel-k/instance/integration-platform/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/red-hat-camel-k/instance/integration-platform/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/red-hat-camel-k/instance/integration-platform/overlays/default?ref=main
```