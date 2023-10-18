# OpenShift Node Feature Discovery (NFD)

Installs a basic nodeFeatureDiscovery instance.

## Prerequisites

First, install the [OpenShift NFD Operator](../operator) in your cluster.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

## Overlays

The options for this operator are the following *overlays*:
* [default](overlays/default)

### Default

[default](overlays/default) configures a basic default configuration for a nodeFeatureDiscovery instance.  For more details on customizing the NFD workers, refer to the [docs](https://kubernetes-sigs.github.io/node-feature-discovery/v0.10/advanced/worker-configuration-reference.html).

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Storage System by running from the root `gitops-catalog` directory

```
oc apply -k openshift-nfd-operator/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-nfd-operator/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/openshift-nfd-operator/instance/overlays/default?ref=main
```
