# Bitnami Sealed Secrets

## Project Reference

GitHub: [Bitnami Labs - Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)

## Usage

The main `sealed-secrets-controller` Service Account requires `anyuid` when running in an OpenShift cluster.  A `Role` and `RoleBinding` are provided in the `default` overlay.

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
  - github.com/redhat-canada-gitops/catalog/sealed-secrets/overlays/default

resources:
  - namespace.yaml
```
