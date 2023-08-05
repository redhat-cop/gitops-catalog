# edge-termination

## Purpose
This component is designed to enable Edge Termination on the ArgoCD route, and resolving the "Insecure Route" message created by ArgoCD's self-signed certificate.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/edge-termination
```