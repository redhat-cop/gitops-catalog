# timeout-12m

## Purpose
This component is designed to modify the amount of time a DevSpaces environment can remain idle before it is automatically shut down.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/low-idle
```