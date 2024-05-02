# console-plugin-helm

## Purpose

This component is designed to enable to NVIDIA GPU Operator console plugin.

This component renders the upstream helm chart for the console plugin, and runs a job that enables the console-plugin.

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
  - ../../components/console-plugin-helm
```

This component requires the `--enable-helm` flag when applying this resource with `kustomize build`.

If applying this resource with ArgoCD, be sure to configure the `--enable-helm` flag with ArgoCD.  For examples, see the [here](https://github.com/redhat-cop/gitops-catalog/tree/main/openshift-gitops-operator/instance/components/kustomize-build-enable-helm).
