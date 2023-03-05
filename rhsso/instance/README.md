# Red Hat Single Sign-On instance

Installs the `Keycloak` using the default overlay.

## Usage

If you have cloned the `gitops-catalog` repository, you can install the `Keycloak` from the root `gitops-catalog` directory

```
oc apply -k rhsso/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/rhsso/instance/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/rhsso/instance/overlays/default?ref=main
```