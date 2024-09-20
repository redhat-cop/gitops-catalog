# Apicurio Registry Operator

Install Apicurio Registry Operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the intended version of Apicurio Registry.

the current *overlays* available are for the following channels:

* [2.x](operator/overlays/2.x)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Apicurio Registry Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k apicurio-registry-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/apicurio-registry-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/apicurio-registry-operator/operator/overlays/<channel>?ref=main
```

## Deploying Apicurio Registry

If you would like to deploy Apicurio Registry, you can try one of the samples in the `instance/overlays` directory.

## All-in-One

If you would like to deploy the operator *and* Apicurio Registry and a backing store all in one line, use one of the `aggregate` directories, for example:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/apicurio-registry-operator/aggregate/apicurio-registry-sql?ref=main
```
