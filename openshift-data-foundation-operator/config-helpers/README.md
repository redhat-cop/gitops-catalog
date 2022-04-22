# OpenShift Data Foundation - Config Helpers

Configuration helpers useful for automating some configurations needed to setup the operator.

## Node Labeler

The [node-labeler](/node-labeler/) is a helpful addition to any ODF instance overlays and can be used in combination with them.

node-labeler creates a job that is responsible for applying the `cluster.ocs.openshift.io/openshift-storage=""` label to nodes needed for the ODF/OCS to install.  If your cluster does not have the minimum three worker nodes the job will fail.

### Overlays

The node-labeler config helper for this operator currently offeres the following *overlays*:
* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Storage System by running from the root `gitops-catalog` directory

```
oc apply -k openshift-data-foundation-operator/config-helpers/node-labeler/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-data-foundation-operator/config-helpers/node-labeler/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-data-foundation-operator/config-helpers/node-labeler/overlays/default?ref=main
```
