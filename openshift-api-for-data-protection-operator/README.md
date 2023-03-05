# OpenShift API for Data Protection (OADP) Operator

This is to deploy [OADP](https://docs.openshift.com/container-platform/4.10/backup_and_restore/index.html#application-backup-restore-operations-overview) into an OpenShift cluster.

This operator provides functionality to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [stable](overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```bash
oc apply -k openshift-api-for-data-protection-operator/overlays/<channel>
```

Or, without cloning:

```bash
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-api-for-data-protection-operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/openshift-api-for-data-protection-operator/overlays/<channel>?ref=main
```
