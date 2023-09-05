# NVIDIA GPU Operator

Installs the NVIDIA GPU Operator.

## Prerequisites

First, install the [NVIDIA GPU Operator](../operator) in your cluster.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

## Overlays

The options for this operator are the following *overlays*:
* [default](overlays/default)

### Default

[default](overlays/default) configures the NVIDIA GPU Operator.

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Storage System by running from the root `gitops-catalog` directory

```
oc apply -k nvidia-gpu-operator/operator/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/nvidia-gpu-operator/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/nvidia-gpu-operator/instance/overlays/default?ref=main
```