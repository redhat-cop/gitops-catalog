# OpenShift Image Registry

Configures the integrated Image Registry

Do not use the `base` directory directly, as you will need to patch the following based on the Storage you are using: 
* the `rolloutStrategy`
* the `storage`

The current *overlays* available are:
* [vsphere](overlays/vsphere). This enables the registry using a PVC with block storage.

## Prerequisites

Set the size of the PVC in the openshift-image-registry/overlays/provider/kustomization.yaml, the default is '5Gi'.

## Usage

If you have cloned the `gitops-catalog` repository, you can install Logging infrastructure by running from the root `gitops-catalog` directory

```
oc apply -k openshift-image-registry/overlays/provider
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-image-registry/overlays/provider
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-image-registry/overlays/provider?ref=main
```
