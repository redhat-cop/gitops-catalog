# mig-mixed

## Purpose

This component is designed to enable to enable MIG in mixed mode.  The mixed MIG strategy should be utilized when not all GPUs on a node have MIG enabled.

To learn more about MIG, please refer to the official [docs](
https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/gpu-operator-mig.html)

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/mig-mixed
```
