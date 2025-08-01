# notebook-pod-sizes

## Purpose
This component is designed help admins configure the default sizes users can select from when creating a new Workbenches.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/notebook-pod-sizes
```

You can customize the pod sizes by updating the [patch-rhoai-dashboard.yaml](./patch-rhoai-dashboard.yaml) file.
