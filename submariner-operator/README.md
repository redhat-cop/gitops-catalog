# Submariner Operator

This is to deploy [submariner](https://submariner.io/getting-started/quickstart/openshift/) into an OpenShift cluster.

This operator enables direct networking between Pods and Services in different Kubernetes clusters, either on-premises or in the cloud.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [stable-0-12](overlays/stable-0-12)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Logging operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```bash
oc apply -k submariner-operator/overlays/<channel>
```

Or, without cloning:

```bash
oc apply -k https://github.com/redhat-cop/gitops-catalog/submariner-operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/submariner-operator/overlays/<channel>?ref=main
```
