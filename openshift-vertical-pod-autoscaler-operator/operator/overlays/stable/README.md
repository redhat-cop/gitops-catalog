# OpenShift Vertical Pod Autoscaler Operator

Installs the OpenShift Vertical Pod Autoscaler Operator using the stable channel.

The operator is installed in the `openshift-vertical-pod-autoscaler` namespace.

## Description

The Vertical Pod Autoscaler (VPA) automatically adjusts the resource requests and limits of containers in pods based on their historical resource usage. This helps to ensure that pods have the appropriate resources allocated to them, which can improve cluster resource utilization and application performance.

## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Vertical Pod Autoscaler Operator by running from the root (`gitops-catalog`) directory:

```
oc apply -k openshift-vertical-pod-autoscaler-operator/operator/overlays/stable
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-vertical-pod-autoscaler-operator/operator/overlays/stable?ref=main
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/openshift-vertical-pod-autoscaler-operator/operator/overlays/stable?ref=main
```
