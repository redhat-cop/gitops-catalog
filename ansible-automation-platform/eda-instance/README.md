# Ansible Automation Platform instances

Installs the Automation EDA Controller

## Prerequisites

The current *overlays* available are:

* [default](overlays/default)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Logging infrastructure by running from the root `gitops-catalog` directory

```bash
oc apply -k ansible-automation-platform/eda-instance/overlays/default
```

Or, without cloning:

```bash
oc apply -k https://github.com/redhat-cop/gitops-catalog/ansible-automation-platform/eda-instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/ansible-automation-platform/eda-instance/overlays/default?ref=main
```
