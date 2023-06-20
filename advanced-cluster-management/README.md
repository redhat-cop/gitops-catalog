# Advanced Cluster Management for Kubernetes

Install Advanced Cluster Management for Kubernetes.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [release-2.4](operator/overlays/release-2.4)
* [release-2.5](operator/overlays/release-2.5)
* [release-2.6](operator/overlays/release-2.6)
* [release-2.7](operator/overlays/release-2.7)
* [release-2.8](operator/overlays/release-2.8)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Advanced Cluster Management for Kubernetes based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k advanced-cluster-management/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/advanced-cluster-management/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/advanced-cluster-management/operator/overlays/<channel>?ref=main
```
