# separate-namespace

## Purpose

This component is designed move installation of the Crunchy Postgres Operator into its own namespace. This facilitates
better control of upgrade approval for this operator without impacting other operators.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/separate-namespace
```
