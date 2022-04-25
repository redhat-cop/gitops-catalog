# Container Security Operator

Installs the Container Security operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [quay-v3.5](overlays/quay-v3.5)
* [stable-3.6](overlays/stable-3.6)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Ansible Automation Platform operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k container-security-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/container-security-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/container-security-operator/operator/overlays/<channel>?ref=main
```