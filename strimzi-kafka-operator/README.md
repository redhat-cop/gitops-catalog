# Strimzi

Install Strimzi.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)
* [strimzi-0.23.x](operator/overlays/strimzi-0.23.x)
* [strimzi-0.24.x](operator/overlays/strimzi-0.24.x)
* [strimzi-0.25.x](operator/overlays/strimzi-0.25.x)
* [strimzi-0.26.x](operator/overlays/strimzi-0.26.x)
* [strimzi-0.27.x](operator/overlays/strimzi-0.27.x)
* [strimzi-0.28.x](operator/overlays/strimzi-0.28.x)
* [strimzi-0.29.x](operator/overlays/strimzi-0.29.x)
* [strimzi-0.30.x](operator/overlays/strimzi-0.30.x)
* [strimzi-0.31.x](operator/overlays/strimzi-0.31.x)
* [strimzi-0.32.x](operator/overlays/strimzi-0.32.x)
* [strimzi-0.33.x](operator/overlays/strimzi-0.33.x)
* [strimzi-0.34.x](operator/overlays/strimzi-0.34.x)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Strimzi based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k strimzi-kafka-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/strimzi-kafka-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/strimzi-kafka-operator/operator/overlays/<channel>?ref=main
```
