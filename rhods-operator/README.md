# Red Hat OpenShift AI

Install Red Hat OpenShift AI.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [alpha](operator/overlays/alpha)
* [beta](operator/overlays/beta)
* [embedded](operator/overlays/embedded)
* [eus-2.8](operator/overlays/eus-2.8)
* [fast](operator/overlays/fast)
* [stable](operator/overlays/stable)
* [stable-2.8](operator/overlays/stable-2.8)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat OpenShift AI based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k rhods-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/rhods-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/rhods-operator/operator/overlays/<channel>?ref=main
```
