# OpenShift Quay Operator

Installs the Quay Registry operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [stable-3.6](overlays/stable-3.6)
* [stable-3.7](overlays/stable-3.7)
* [stable-3.8](overlays/stable-3.8)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Quay operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k quay-registry-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/quay-registry-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/quay-registry-operator/operator/overlays/<channel>?ref=main
```
