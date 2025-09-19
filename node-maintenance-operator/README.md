# Node Maintenance Operator

This is to deploy the [Node Maintenance operator](https://docs.redhat.com/en/documentation/workload_availability_for_red_hat_openshift/25.4/html/remediation_fencing_and_maintenance/node-maintenance-operator) to OpenShift. You can use the Node Maintenance Operator to place nodes in maintenance mode by using the oc adm utility or NodeMaintenance custom resources (CRs).

The Node Maintenance Operator is a "Rolling Stream" Operator, meaning updates are available asynchronously of OpenShift Container Platform releases. For more information, see OpenShift Operator Life Cycles on the Red Hat Customer Portal.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k node-maintenance-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/node-maintenance-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/node-maintenance-operator/operator/overlays/<channel>?ref=main
```
