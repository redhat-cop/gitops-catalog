# monitoring-dashboard

[NVIDIA Enable Monitoring Dashboard Docs](
https://docs.nvidia.com/datacenter/cloud-native/openshift/latest/enable-gpu-monitoring-dashboard.html)

## Purpose

This component is designed to enable to enable the GPU monitoring Dashboard.

To learn more about the monitoring dashboard, please refer to the official [docs](
https://docs.nvidia.com/datacenter/cloud-native/openshift/latest/enable-gpu-monitoring-dashboard.html)

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/monitoring-dashboard
```
