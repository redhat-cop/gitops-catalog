# Self Node Remediation Operator

This is to deploy the [Self Node Remediation operator](https://docs.redhat.com/en/documentation/workload_availability_for_red_hat_openshift/25.4/html/remediation_fencing_and_maintenance/self-node-remediation-operator-remediate-nodes) to OpenShift. This self node remediation operator is using an alternate mechanism for a node in a cluster to detect its health status and take actions to remediate itself in case of a failure.

The Self Node Remediation is a "Rolling Stream" Operator, meaning updates are available asynchronously of OpenShift Container Platform releases. For more information, see OpenShift Operator Life Cycles on the Red Hat Customer Portal.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k self-node-remediation-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/self-node-remediation-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/self-node-remediation-operator/operator/overlays/<channel>?ref=main
```
