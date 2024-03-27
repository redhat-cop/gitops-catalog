# kustomize-build-policy-generator

## Purpose
This component is designed to turn on the `--enable-helm` feature of `kustomize build` in ArgoCD to support helm charts inside of a kustomization.yaml file.

To learn more about the `--enable-helm` feature, refer to the ArgoCD docs [here](https://argo-cd.readthedocs.io/en/stable/user-guide/kustomize/#kustomizing-helm-charts) or the kustomize [examples](https://github.com/kubernetes-sigs/kustomize/blob/master/examples/chart.md).

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/kustomize-build-policy-generator
```

## Known Incompatibilities

### kustomize-build-enable-helm

This component is not compatible with the [kustomize-build-enable-helm](openshift-gitops-operator/instance/components/kustomize-build-enable-helm) component.

Both components are attempting to patch the `spec.kustomizeBuildOptions` field.
