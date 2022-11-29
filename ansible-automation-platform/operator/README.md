# Ansible Automation Platform Operator

Installs the Ansible Automation Platform operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable-2.1](overlays/stable-2.1)
* [stable-2.1-cluster-scoped](overlays/stable-2.1-cluster-scoped)
* [stable-2.2](overlays/stable-2.2)
* [stable-2.2-cluster-scoped](overlays/stable-2.2-cluster-scoped)
* [stable-2.3](overlays/stable-2.3)
* [stable-2.3-cluster-scoped](overlays/stable-2.3-cluster-scoped)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Ansible Automation Platform operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```bash
oc apply -k ansible-automation-platform/operator/overlays/<channel>
```

Or, without cloning:

```bash
oc apply -k https://github.com/redhat-cop/gitops-catalog/ansible-automation-platform/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/ansible-automation-platform/operator/overlays/<channel>?ref=main
```
