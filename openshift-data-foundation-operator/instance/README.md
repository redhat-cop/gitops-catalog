# OpenShift Data Foundation

Installs a basic Storage System using the OpenShift Data Foundation Operator.

## Prerequisites

OpenShift Data Foundation requires a minimum three worker nodes to install and configure a ceph cluster using OpenShift Data Foundation.

First, install the [OpenShift Data Foundation Operator](../operator) in your cluster.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

## Overlays

The options for this operator are the following *overlays*:

* [aws](overlays/aws)
* [vsphere](overlays/vsphere)

In order for ODF/OCS to configure storage using the overlays, they expect nodes with the following label to be present on the nodes ODF/OCS will install the cluster:

```
cluster.ocs.openshift.io/openshift-storage=""
```

You will need to manually add this label to nodes if they are not already present:

```
oc label nodes <node-name> cluster.ocs.openshift.io/openshift-storage="" --overwrite=true
```

For additional automation for labeling nodes see [node-labeler](../config-helpers/node-labeler/)

### AWS

[aws](overlays/aws) installs a basic StorageSystem.  The StorageSystem will configure the OpenShift Container Storage Operator and also install a StorageCluster and OCSInitialization object to configure the storage cluster.  The StorageCluster is configured to work with gp2 storage on an AWS cluster.

### vSphere

[vsphere](overlays/vsphere) installs a basic StorageSystem.  The StorageSystem will configure the OpenShift Container Storage Operator and also install a StorageCluster and OCSInitialization object to configure the storage cluster.  The StorageCluster is configured to work with thin storage on a vSphere cluster and enables flexible scaling to distribute devices evenly across all nodes, regardless of distribution in zones or racks.

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Storage System by running from the root `gitops-catalog` directory

```
oc apply -k openshift-data-foundation-operator/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-data-foundation-operator/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/openshift-data-foundation-operator/instance/overlays/default?ref=main
```
