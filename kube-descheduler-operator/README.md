# Kube Descheduler Operator

This is to deploy the [Kube Descheduler Operator](https://docs.redhat.com/en/documentation/openshift_container_platform/4.19/html/nodes/controlling-pod-placement-onto-nodes-scheduling#descheduler) to OpenShift. The Kube Descheduler Operator provides the ability to evict a running pod so that the pod can be rescheduled onto a more suitable node.

There are several situations where the descheduler can benefit your cluster:

- Nodes are underutilized or over-utilized.
- Pod and node affinity requirements, such as taints or labels, have changed and the original scheduling decisions are no longer appropriate for certain nodes.
- Node failure requires pods to be moved.
- New nodes are added to clusters.

The Kube Descheduler Operator is a "Rolling Stream" Operator, meaning updates are available asynchronously of OpenShift Container Platform releases. For more information, see OpenShift Operator Life Cycles on the Red Hat Customer Portal.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k kube-descheduler-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/kube-descheduler-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/kube-descheduler-operator/operator/overlays/<channel>?ref=main
```
