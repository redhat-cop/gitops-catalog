# Advanced Cluster Management instances

Supports `MultiClusterHub` CR and the `MultiClusterObservability`.

## Base

Installs the `MultiClusterHub`.

There is no customization to do at this point. Simply, apply the `base`.

### Usage

If you have cloned the `gitops-catalog` repository, you can install the MultiClusterHub from the root `gitops-catalog` directory

```
oc apply -k advanced-cluster-management/instance/base
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/advanced-cluster-management/instance/base
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/advanced-cluster-management/instance/base?ref=main
```


## Observability

Installs the `MultiClusterObservability`. It requires the kind `ObjectBucketClaim` to be available in the cluster. It can comes from ODF.

There is no customization to do at this point. Simply, apply the `observability`.

### Usage

If you have cloned the `gitops-catalog` repository, you can install the MultiClusterHub from the root `gitops-catalog` directory

```
oc apply -k advanced-cluster-management/instance/observability
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/advanced-cluster-management/instance/observability
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/advanced-cluster-management/instance/observability?ref=main
```