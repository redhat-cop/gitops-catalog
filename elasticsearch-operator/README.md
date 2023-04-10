# OpenShift Elasticsearch Operator

Installs the OpenShift Elasticsearch operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [4.6](overlays/4.6)
* [5.0](overlays/5.0)
* [stable](overlays/stable)
* [stable-5.1](overlays/stable-5.1)
* [stable-5.2](overlays/stable-5.2)
* [stable-5.3](overlays/stable-5.3)
* [stable-5.4](overlays/stable-5.4)
* [stable-5.5](overlays/stable-5.5)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Elasticsearch operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k elasticsearch-operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/elasticsearch-operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/elasticsearch-operator/overlays/<channel>?ref=main
```
