# Red Hat OpenShift Serverless

Install Red Hat OpenShift Serverless.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)
* [stable-1.29](operator/overlays/stable-1.29)
* [stable-1.30](operator/overlays/stable-1.30)
* [stable-1.31](operator/overlays/stable-1.31)
* [stable-1.32](operator/overlays/stable-1.32)
* [stable-1.33](operator/overlays/stable-1.33)
* [stable-1.34](operator/overlays/stable-1.34)
* [stable-1.35](operator/overlays/stable-1.35)
* [stable-1.36](operator/overlays/stable-1.36)
* [stable-1.37](operator/overlays/stable-1.37)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat OpenShift Serverless based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k serverless-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/serverless-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/serverless-operator/operator/overlays/<channel>?ref=main
```
