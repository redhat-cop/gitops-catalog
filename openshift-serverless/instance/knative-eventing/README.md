# OpenShift Serverless - Knative Eventing

Installs the Knative Eventing component of OpenShift Serverless.

## Prerequisites

First, install the [OpenShift Serverless Operator](../../operator) in your cluster.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are:
* [default](overlays/default)
* [knative-kafka](overlays/knative-kafka)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Noobaa by running from the root `gitops-catalog` directory

```
oc apply -k openshift-serverless/instance/knative-eventing/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-serverless/instance/knative-eventing/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-serverless/instance/knative-eventing/overlays/default?ref=main
```