# annotation-resource-tracking

## Purpose
This component is designed to enable ArgoCD's annotation based resource tracking method, instead of the default label based tracking method.

To learn more about the different resource tracking methods, consult the documentation [here](https://argo-cd.readthedocs.io/en/stable/user-guide/resource_tracking/#additional-tracking-methods-via-an-annotation).

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/annotation-resource-tracking
```