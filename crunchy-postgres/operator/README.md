# Crunchy Postgres Certified Operator

Installs the Crunchy Postgres Certified operator into all namespaces.

Current channel overlays include:
* v5

## Usage

If you have cloned the `gitops-catalog` repository, you can install the Crunchy Postgres Certified operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k crunchy-postgres/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/crunchy-postgres/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/crunchy-postgres/operator/overlays/<channel>?ref=main
```
