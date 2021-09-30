# Install Plan Approver

In OCP 4 when you set an operator for manual upgrades you need to manually approve the initial deployment which is challenging in a gitops world. The installplan-approver-job created by Andrew Pitt can be used to approve all pending installplans in the namespace in which it is deployed.

## Usage

If you have cloned the `gitops-catalog` repository, you can install the installplan-approver job based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k installplan-approver/base
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/installplan-approver/base
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/installplan-approver/base?ref=main
```
