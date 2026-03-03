# Ansible Automation Platform instances

Installs the Automation Platform

## Prerequisites

Do not use the `base` directory directly, as you will need to patch

* the `ConsoleLink`

The current *overlays* available are:

* [default](overlays/default)

## Usage
This is using the default deploy all component CR, please refer to [AAP 2.6 Docs](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/html/installing_on_openshift_container_platform/appendix-operator-crs_appendix-operator-crs#operator-crs) for example custom resources for connecting exsiting components

If you have cloned the `gitops-catalog` repository, you can install Logging infrastructure by running from the root `gitops-catalog` directory

```bash
oc apply -k ansible-automation-platform/platform-instance/overlays/default
```

Or, without cloning:

```bash
oc apply -k https://github.com/redhat-cop/gitops-catalog/ansible-automation-platform/platform-instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/ansible-automation-platform/platform-instance/overlays/default?ref=main
```
