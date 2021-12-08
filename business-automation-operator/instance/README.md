# Business Automation instances

Installs a KieApp instance.

## Prerequisites

Do not use the `base` directory directly.

The current *overlays* available are:
* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Logging infrastructure by running from the root `gitops-catalog` directory

```
oc apply -k business-automation-operator/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/business-automation-operator/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/business-automation-operator/instance/overlays/default?ref=main
```
