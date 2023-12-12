# OpenShift sandboxed containers Operator

Install OpenShift sandboxed containers Operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [preview-1.0](operator/overlays/preview-1.0)
* [preview-1.1](operator/overlays/preview-1.1)
* [stable](operator/overlays/stable)
* [stable-1.2](operator/overlays/stable-1.2)
* [stable-1.3](operator/overlays/stable-1.3)

## Usage

If you have cloned the `gitops-catalog` repository, you can install OpenShift sandboxed containers Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k sandboxed-containers-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/sandboxed-containers-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/sandboxed-containers-operator/operator/overlays/<channel>?ref=main
```
