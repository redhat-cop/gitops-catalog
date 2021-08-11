# OpenShift ServiceMesh - Control Plane

Installs the Control Plane component of OpenShift ServiceMesh.

## Prerequisites

First, install the following operators in your cluster:

- [Openshift Elasticsearch Operator](../../elasticsearch-operator)
- [Red Hat Openshift Jaeger Operator](../../jaeger-operator)
- [Kiali Operator](../../kaili-operator)
- [OpenShift ServiceMesh Operator](../operator)

Review the [Service Mesh Install](https://docs.openshift.com/container-platform/4.7/service_mesh/v1x/installing-ossm.html#jaeger-operator-install-elasticsearch_installing-ossm-v1x) documentation for information on specific versions of the operators to install for your cluster version.

Do not use the `base` directory directly, as you will need to patch the `channel` and `version` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are:
* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Noobaa by running from the root `gitops-catalog` directory

```
oc apply -k openshift-servicemesh/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-servicemesh/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-servicemesh/instance/overlays/default?ref=main
```