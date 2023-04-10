# Red Hat Single Sign-On

Installs the Red Hat Single Sign-On

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [alpha](overlays/alpha)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat Single Sign On based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k rhsso/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/rhsso/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/rhsso/operator/overlays/<channel>?ref=main
```
