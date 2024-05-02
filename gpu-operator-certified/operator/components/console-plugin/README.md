# console-plugin

## Purpose

This component is designed to enable to NVIDIA GPU Operator console plugin.

This component creates the console plugin objects, and runs a job that enables the console-plugin.

This component is intended as an alternative to the `console-plugin-helm` which directly references the upstream helm chart used to install/configure the console-plugin.  This component has pre-rendered the helm chart objects and does not require the usage of the `--enable-helm` flag.

To learn more about the console plugin, please refer to the official [docs](
https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/openshift/enable-gpu-op-dashboard.html)

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/console-plugin
```
