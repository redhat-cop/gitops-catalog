# nvidia-gpu-accelerator-profile

## Purpose
This component is designed help admins configure an accelerator profile with NVIDIA GPUs.

For more information on accelerators, please see the [Working with accelerators](https://access.redhat.com/documentation/en-us/red_hat_openshift_ai_self-managed/2-latest/html/working_on_data_science_projects/working-with-accelerators_accelerators) documentation.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/nvidia-gpu-accelerator-profile
```

You can customize the pod sizes by updating the [patch-rhoai-dashboard.yaml](./patch-rhoai-dashboard.yaml) file.
