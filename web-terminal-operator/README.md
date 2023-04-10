# OpenShift Web Terminal Operator

Installs the Web Terminal Operator.

This operator enables you to run a web terminal within the OpenShift Console GUI giving easy availability to tools like oc, helm, etc.

This operator depends on the DevWorkspace Operator which will be installed automatically when you install this operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [fast](operator/overlays/fast)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift Data Foundation operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k web-terminal-operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/web-terminal-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/web-terminal-operator/operator/overlays/<channel>?ref=main
```

## A Note on Previous Versions

Older versions of the Web Terminal Operator required users to configure a DevWorkspaces instance which is no longer required in the current version of the Web Terminal Operator.  The Web Terminal Operator will automatically configure any necessary DevWorkspaces components automatically.
