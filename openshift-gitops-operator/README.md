# Red Hat OpenShift GitOps

Install Red Hat OpenShift GitOps.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [gitops-1.3](operator/overlays/gitops-1.3)
* [gitops-1.4](operator/overlays/gitops-1.4)
* [gitops-1.5](operator/overlays/gitops-1.5)
* [gitops-1.6](operator/overlays/gitops-1.6)
* [gitops-1.7](operator/overlays/gitops-1.7)
* [gitops-1.8](operator/overlays/gitops-1.8)
* [gitops-1.9](operator/overlays/gitops-1.9)
* [latest](operator/overlays/latest)
* [preview](operator/overlays/preview)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat OpenShift GitOps based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k openshift-gitops-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-gitops-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/openshift-gitops-operator/operator/overlays/<channel>?ref=main
```
