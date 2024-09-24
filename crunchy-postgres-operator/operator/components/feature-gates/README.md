# feature-gates

## Purpose

This component is designed facilitate enabling of feature gates with the Crunchy Postgres Operator, such as the
"AutoCreateUserSchema" feature gate.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/feature-gates
```
