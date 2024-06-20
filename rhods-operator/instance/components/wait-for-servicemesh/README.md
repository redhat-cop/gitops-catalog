# wait-for-servicemesh

## Purpose
This component is designed prevent OpenShift AI before the ServiceMesh resources have been successfully installed that are required for KServe.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/wait-for-servicemesh
```
