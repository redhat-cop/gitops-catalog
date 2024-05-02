# allow-autoscaling

## Purpose
This component is designed to extend the timeout period for requesting new DevSpaces environments to start.  The 12 minute timeout can be leveraged with autoscaling nodes with GPUs.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/allow-autoscaling
```