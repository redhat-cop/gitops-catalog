# Node Healthcheck Operator

This is to deploy the [Node Healthcheck operator](https://docs.redhat.com/en/documentation/workload_availability_for_red_hat_openshift/25.4/html/remediation_fencing_and_maintenance/node-health-check-operator) to OpenShift. You can use the Node Health Check Operator to identify unhealthy nodes. The Operator then uses other remediation providers to remediate the unhealthy nodes.

The Node Health Check Operator can be used with the other remediation providers, including:

- The Self Node Remediation Operator.
- The Fence Agents Remediation Operator.
- The Machine Deletion Remediation Operator.

The Node Healthcheck Operator is a "Rolling Stream" Operator, meaning updates are available asynchronously of OpenShift Container Platform releases. For more information, see OpenShift Operator Life Cycles on the Red Hat Customer Portal.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k node-healthcheck-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/node-healthcheck-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/node-healthcheck-operator/operator/overlays/<channel>?ref=main
```
