# OpenShift Container Storage - Noobaa (S3)

Installs the Noobaa component of OpenShift Container Storage.

Certain Red Hat Tools and Application Services require S3 storage.  This includes the [Migration Toolkit for Containers](https://docs.openshift.com/container-platform/4.7/migration/migrating_3_4/about-migration.html), [Red Hat Quay](https://www.redhat.com/en/technologies/cloud-computing/quay), and [3Scale API Management](https://www.redhat.com/en/technologies/jboss-middleware/3scale) to name a few.

For demos, it is sometimes easier (and lighter) to deploy Noobaa in your cluster to provide that S3 capability.

## Prerequisites

First, install the [OpenShift Container Storage Operator](../openshift-container-storage-operator) in your cluster.



Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are:
* [default](overlays/default) - a small storage cluster (10Gi).

## Usage

If you have cloned the `gitops-catalog` repository, you can install Noobaa by running from the root `gitops-catalog` directory

```
oc apply -k openshift-container-storage-noobaa/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-container-storage-noobaa/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/openshift-container-storage-noobaa/overlays/default?ref=main
```