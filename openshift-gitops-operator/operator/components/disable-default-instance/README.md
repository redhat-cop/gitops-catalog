# disable-default-instance

## Purpose
This component disables the creation of a default ArgoCD instance in the `openshift-gitops` namespace.

For more information on this option please refer to the following:

[5 global environment variables provided by OpenShift GitOps](https://developers.redhat.com/articles/2023/03/06/5-global-environment-variables-provided-openshift-gitops)

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/disable-default-instance
```
