# Bitnami Sealed Secrets

**Version: 0.19.4**

## Project Reference

GitHub: [Bitnami Labs - Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)

## Usage

The default `namespace` provided in this repository is `sealed-secrets`. If you would like to use a different namespace you'll have to patch the name value for the `Namespace` kind in your `kustomization.yaml`.

**kustomization.yaml**
```
kind: Kustomization
apiVersion: kustomize.config.k8s.io/v1beta1

# Remote base.  Use the configuration from the Red Hat GitOps Catalog repo (unofficial).
resources:
  - https://github.com/redhat-cop/gitops-catalog/sealed-secrets-operator/overlays/default
```

> :rotating_light: **NOTE**: If you create a namespace other than `sealed-secrets`, you'll have to add that namespace to the `kustomization.yaml` file. For example: if you created a namespace called `foobar`. Then you need to add `namespace: foobar` to the `kustomization.yaml` file.

## Scripts

For demo or DR purposes, it can be important to be able to re-use the same sealed secrets key so you do not have to re-encrypt your secrets in git. There are a couple of scripts provided here to show how you can do this:

a. get-sealed-secret-key.sh - This gets a copy of the existing sealed-secret key and stores it on your local machine
b. replace-sealed-secrets-secret.sh - This replaces an existing key with the one on your machine.

Note that you can also deploy the key in advance in the same namespace where you are deploying the operator, this can be convenient when using GitOps tools like ArgoCD.
