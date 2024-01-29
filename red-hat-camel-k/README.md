# Red Hat Integration - Camel K

Install Red Hat Integration - Camel K.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [1.10.x](operator/overlays/1.10.x)
* [1.4.x](operator/overlays/1.4.x)
* [1.6.x](operator/overlays/1.6.x)
* [1.8.x](operator/overlays/1.8.x)
* [candidate](operator/overlays/candidate)
* [latest](operator/overlays/latest)
* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat Integration - Camel K based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k red-hat-camel-k/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/red-hat-camel-k/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/red-hat-camel-k/operator/overlays/<channel>?ref=main
```
