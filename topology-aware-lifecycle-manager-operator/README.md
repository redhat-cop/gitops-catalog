# Topology Aware Lifecycle Manager (TALM) Operator

## Usage

This is to deploy [Topology Aware Lifecycle Manager (TALM)](https://docs.openshift.com/container-platform/4.10//scalability_and_performance/cnf-talm-for-cluster-upgrades.html) into an OpenShift cluster. This operator
manages the software lifecycle of multiple single-node OpenShift (SNO) clusters. TALM uses Red Hat Advanced Cluster Management (RHACM) policies to perform changes on the target clusters.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channel:
* [stable](overlays/stable)

If you want to use the latest stable version of Topology Aware Lifecycle Manager, it is recommended that you use the `stable` channel.


## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Topology Aware Lifecycle Manager operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k topology-aware-lifecycle-manager-operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/topology-aware-lifecycle-manager-operator/overlays/<channel>
```
