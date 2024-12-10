# rhoai-dashboard-access

## Purpose
This component is designed help admins configure the default access to the RHOAI Dashboard.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/rhoai-dashboard-access
```

You can customize the access by updating the [patch-rhoai-dashboard.yaml](./patch-rhoai-dashboard.yaml) file.
