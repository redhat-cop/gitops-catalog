# External Secrets Operator

## Usage

This will deploy the [External Secrets Operator](https://github.com/external-secrets/external-secrets) into an OpenShift 4.7 or later cluster. This operator allows you create git-safe `ExternalSecret` CRDs that reference secrets held in an external secrets manager such as AWS SecretManager, Azure Key Vault, Hashicorp Vault, etc... This is one way to safely manage secrets in a GitOps workflow.

After installing the operator and instance, you will need to create a `SecretStore` to configure the details of how External Secrets can connect to your chosen secret manager.  When that is in place, you can create `ExternalSecret` CRDs to create a normal Kubernetes Secret from the values it references in the secret store.

## Install Operator

Reference one of the `operator/overlay` directories.  For example:

```
oc apply -k external-secrets-operator/operator/overlays/alpha
```

Or as part of your own `kustomization.yaml` file:

```
kind: Kustomization
apiVersion: kustomize.config.k8s.io/v1beta1

resources:
- github.com/redhat-cop/gitops-catalog/external-secrets-operator/operator/overlays/alpha?ref=main
```

## Install an Instance

Once the operator is installed, you need to create an `OperatorConfig` CRD to complete the deployment.

Reference on of the `instance/overlay` directories.  For example:

```
oc apply -k external-secrets-operator/instance/overlays/default
```

Or as part of your own `kustomization.yaml` file:

```
kind: Kustomization
apiVersion: kustomize.config.k8s.io/v1beta1

resources:
- github.com/redhat-cop/gitops-catalog/external-secrets-operator/instance/overlays/default?ref=main
```
