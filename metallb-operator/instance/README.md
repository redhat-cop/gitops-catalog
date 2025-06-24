# MetalLB - Instance

Installs a MetalLB instance so that the operator can be used.

## Prerequisites

First, install the following operators in your cluster:

- [MetalLB Operator](../operator)

Do not use the `base` directory directly, use the `overlays` directory.

The current *overlays* available are:
* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install MetalLB by running from the root `gitops-catalog` directory

```
oc apply -k metallb-operator/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/metallb-operator/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/metallb-operator/instance/overlays/default?ref=main
```
