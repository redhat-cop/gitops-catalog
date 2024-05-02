# NVIDIA GPU Operator Components

The included components are intended to be common patching patterns used on top of the default NVIDIA GPU operator instance to configure additional features.  Components are composable patches that can be added at the overlays layer on top of a base.

This repo currently contains the following components:

* [aws-gpu-machineset](aws-gpu-machineset)
* [mig-mixed](mig-mixed)
* [mig-single](mig-single)
* [monitoring-dashboard](monitoring-dashboard)
* [time-sliced](time-sliced)
* [time-sliced-2](time-sliced-2)
* [time-sliced-4](time-sliced-4)

## Usage

Components can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/monitoring-dashboard
```
