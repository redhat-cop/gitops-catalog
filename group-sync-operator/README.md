# Group Sync Operator

Installs the [Group Sync Operator](https://github.com/redhat-cop/group-sync-operator) into a namespace called `group-sync-operator`.

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Group Sync Operator by running the following command from the root `gitops-catalog` directory

```
oc apply -k group-sync-operator/base
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/group-sync-operator/base
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/group-sync-operator/base?ref=main
```
