# 

Install .

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [quay-v3.4](operator/overlays/quay-v3.4)
* [quay-v3.5](operator/overlays/quay-v3.5)
* [stable-3.6](operator/overlays/stable-3.6)
* [stable-3.7](operator/overlays/stable-3.7)
* [stable-3.8](operator/overlays/stable-3.8)
* [stable-3.9](operator/overlays/stable-3.9)
* [stable-3.10](operator/overlays/stable-3.10)
* [stable-3.11](operator/overlays/stable-3.11)
* [stable-3.12](operator/overlays/stable-3.12)
* [stable-3.13](operator/overlays/stable-3.13)
* [stable-3.14](operator/overlays/stable-3.14)
* [stable-3.15](operator/overlays/stable-3.15)
* [stable-3.16](operator/overlays/stable-3.16)
* [stable-3.17](operator/overlays/stable-3.17)
* [stable-3.18](operator/overlays/stable-3.18)

## Usage

If you have cloned the `gitops-catalog` repository, you can install  based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k quay-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/quay-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/quay-operator/operator/overlays/<channel>?ref=main
```
