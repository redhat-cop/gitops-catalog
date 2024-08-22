# cert-manager Operator for Red Hat OpenShift

Install cert-manager Operator for Red Hat OpenShift.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable-v1](operator/overlays/stable-v1)
* [stable-v1.10](operator/overlays/stable-v1.10)
* [stable-v1.11](operator/overlays/stable-v1.11)
* [stable-v1.12](operator/overlays/stable-v1.12)
* [stable-v1.13](operator/overlays/stable-v1.13)
* [stable-v1.14](operator/overlays/stable-v1.14)
* [tech-preview](operator/overlays/tech-preview)

## Usage

If you have cloned the `gitops-catalog` repository, you can install cert-manager Operator for Red Hat OpenShift based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k openshift-cert-manager-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-cert-manager-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/openshift-cert-manager-operator/operator/overlays/<channel>?ref=main
```
