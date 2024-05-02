# time-sliced

## Purpose

This component is designed to enable to enable time slicing on GPUs.

To learn more about the monitoring dashboard, please refer to the official [docs](
https://docs.nvidia.com/datacenter/cloud-native/openshift/latest/time-slicing-gpus-in-openshift.html)

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/time-sliced
```

This component is intended to be used with additional configurations to set the number of replicas.

Please refer to [time-sliced-2](../time-sliced-2) and [time-sliced-4](../time-sliced-4) for complete implementations of the time slicing configuration.
