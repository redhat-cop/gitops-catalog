# openshift-gitops-operator

## Purpose
This component is creates a `Namespace` and `OperatorGroup` to enable the installation of the OpenShift GitOps Operator.

As of OpenShift GitOps 1.11, the operator should be installed in the openshift-gitops-operator namespace by default.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/openshift-gitops-operator
```