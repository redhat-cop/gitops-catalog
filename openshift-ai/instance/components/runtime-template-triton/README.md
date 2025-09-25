# runtime-template-triton

## Purpose
This component is designed configure the Triton Serving Runtime Template.

For more information on the Triton Serving Runtime, refer to the [Custom Runtime Triton](https://ai-on-openshift.io/odh-rhoai/custom-runtime-triton/) documentation.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/runtime-template-triton
```
