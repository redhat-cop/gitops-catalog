# Bitnami Sealed Secrets

**Version: 0.16.0**

## Project Reference

GitHub: [Bitnami Labs - Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)

## Usage

No `namespace` is provided in this repository, so you are free to choose whatever namespace you like.  For example, in your own repository, you might have the following `namespace.yaml` and `kustomization.yaml` to deploy the Sealed Secrets operator into a `sealed-secrets` namespace.

**namespace.yaml**
```
kind: Namespace
apiVersion: v1
metadata:
  name: sealed-secrets
```

**kustomization.yaml**
```
kind: Kustomization
apiVersion: kustomize.config.k8s.io/v1beta1

# Remote base.  Use the configuration from the Red Hat Canada GitOps repo (unofficial).
bases:
  - https://github.com/redhat-cop/gitops-catalog/catalog/sealed-secrets-operator/overlays/default

resources:
  - namespace.yaml
```

## Scripts

For demo or DR purposes, it can be important to be able to re-use the same sealed secrets key so you do not have to re-encrypt your secrets in git. There are a couple of scripts provided here to show how you can do this:

a. get-sealed-secret-key.sh - This gets a copy of the existing sealed-secret key and stores it on your local machine
b. replace-sealed-secrets-secret.sh - This replaces an existing key with the one on your machine.

Note that you can also deploy the key in advance in the same namespace where you are deploying the operator, this can be convenient when using GitOps tools like ArgoCD.
