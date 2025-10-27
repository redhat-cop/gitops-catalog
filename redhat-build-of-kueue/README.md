# Red Hat Build of Kueue

Install Red Hat Build of Kueue.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable-v1.1](operator/overlays/stable-v1.1)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat OpenShift GitOps based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k redhat-build-of-kueue/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/redhat-build-of-kueue/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/redhat-build-of-kueue/operator/overlays/<channel>?ref=main
```
