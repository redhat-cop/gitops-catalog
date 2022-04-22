# OpenShift Serverless Operator

Installs the OpenShift Serverless operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [4.5](overlays/4.5)
* [4.6](overlays/4.6)
* [4.7](overlays/4.7)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Serverless operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k openshift-serverless/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-serverless/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-serverless/operator/overlays/<channel>?ref=main
```
