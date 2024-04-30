# OpenShift GitOps Components

The included components are intended to be common patching patterns used on top of the default OpenShift Gitops operator to configure additional features of the operator.  Components are composable patches that can be added at the overlays layer on top of a base or overlay

This repo currently contains the following components:

* [enable-console-plugin](enable-console-plugin)
* [openshift-gitops-operator](openshift-gitops-operator)

## Usage

Components can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../base
components:
  - ../../components/enable-console-plugin
```
