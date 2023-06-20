# application-controller-cluster-admin

## Purpose
This component is designed to enable the cluster-admin role for the openshift-gitops application-controller service account.  This pattern is generally recommended for demo, development, or sandbox environments and is not recommended for production clusters.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/application-controller-cluster-admin
```

Note: This component will only function with the default `openshift-gitops` instance of ArgoCD and cannot be applied to namespace scoped instances of ArgoCD outside of the primary instance.
