# components-serving-self-signed

## Purpose
This component is designed help configure the serving specific components including the following items:

KServe
ModelMesh

This component enables KServe with a Self Signed certification that is compatible with versions prior to 2.13.

For OpenShift AI 2.13 and new, it is recommended that you use the `components-serving` instead.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/components-serving-self-signed
```
