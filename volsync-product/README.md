# VolSync

Install VolSync.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)
* [stable-0.11](operator/overlays/stable-0.11)
* [stable-0.12](operator/overlays/stable-0.12)
* [stable-0.13](operator/overlays/stable-0.13)
* [stable-0.14](operator/overlays/stable-0.14)
* [stable-0.15](operator/overlays/stable-0.15)
* [stable-0.16](operator/overlays/stable-0.16)

## Usage

If you have cloned the `gitops-catalog` repository, you can install VolSync based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k volsync-product/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/volsync-product/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/volsync-product/operator/overlays/<channel>?ref=main
```
