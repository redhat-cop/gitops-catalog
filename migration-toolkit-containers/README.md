# Migration Toolkit for Containers Operator

This is to deploy the [Migration Toolkit for Containers Operator](https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/migration_toolkit_for_containers/about-mtc) to OpenShift. The Migration Toolkit for Containers (MTC) enables you to migrate stateful application workloads between OpenShift Container Platform 4 clusters at the granularity of a namespace.

The Migration Toolkit for Containers Operator is a "Rolling Stream" Operator, meaning updates are available asynchronously of OpenShift Container Platform releases. For more information, see OpenShift Operator Life Cycles on the Red Hat Customer Portal.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [release-v1.8](operator/overlays/release-v1.8)
* [release-v1.7](operator/overlays/release-v1.7)

## Usage

If you have cloned the `gitops-catalog` repository, you can install operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k migration-toolkit-containers/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/migration-toolkit-containers/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/migration-toolkit-containers/operator/overlays/<channel>?ref=main
```
