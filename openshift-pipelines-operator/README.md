# OpenShift Pipelines Operator

Installs the OpenShift Pipelines (Tekton) operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [latest](overlays/latest)
* [pipelines-1.15](overlays/pipelines-1.15)
* [pipelines-1.16](overlays/pipelines-1.16)
* [pipelines-1.17](overlays/pipelines-1.17)
* [pipelines-1.18](overlays/pipelines-1.18)
* [pipelines-1.19](overlays/pipelines-1.19)
* [pipelines-1.20](overlays/pipelines-1.20)
* [pipelines-1.21](overlays/pipelines-1.21)
* [pipelines-1.22](overlays/pipelines-1.22)
* [pipelines-1.23](overlays/pipelines-1.23)
* [pipelines-1.24](overlays/pipelines-1.24)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Pipelines operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k openshift-pipelines-operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-pipelines-operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/openshift-pipelines-operator/overlays/<channel>?ref=main
```
