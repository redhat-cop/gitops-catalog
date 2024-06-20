# components-distributed-compute

## Purpose
This component is designed help configure the the authentication endpoint for RHOAI with KServe using Authorino with ServiceMesh

The Authorino auth is available in RHOAI 2.9 and later.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/auth-with-authorino
```
