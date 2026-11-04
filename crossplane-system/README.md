# Crossplane System

Install Crossplane System.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current _overlays_ available are for the following channels:

- [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Crossplane System based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k crossplane-system/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/crossplane-system/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/crossplane-system/operator/overlays/<channel>?ref=main
```
