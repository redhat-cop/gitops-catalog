# Crossplane Provider for Keycloak

Install Crossplane Provider for Keycloak.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current _overlays_ available are for the following channels:

- [v1.5.0](operator/overlays/v1.5.0)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Crossplane Provider for Keycloak based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k crossplane-provider-keycloak/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/crossplane-provider-keycloak/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/crossplane-provider-keycloak/operator/overlays/<channel>?ref=main
```
