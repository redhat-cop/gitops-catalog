# health-check-build

## Purpose
This component is designed to enable custom health checks for OpenShift build objects including `builds` and `imagestreams`.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/health-check-openshift-builds
```
