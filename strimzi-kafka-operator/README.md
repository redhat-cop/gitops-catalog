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
* [strimzi-0.35.x](operator/overlays/strimzi-0.35.x)
* [strimzi-0.36.x](operator/overlays/strimzi-0.36.x)
* [strimzi-0.37.x](operator/overlays/strimzi-0.37.x)
* [strimzi-0.38.x](operator/overlays/strimzi-0.38.x)
* [strimzi-0.39.x](operator/overlays/strimzi-0.39.x)
* [strimzi-0.40.x](operator/overlays/strimzi-0.40.x)
* [strimzi-0.41.x](operator/overlays/strimzi-0.41.x)
* [strimzi-0.42.x](operator/overlays/strimzi-0.42.x)
* [strimzi-0.43.x](operator/overlays/strimzi-0.43.x)
* [strimzi-0.44.x](operator/overlays/strimzi-0.44.x)
* [strimzi-0.45.x](operator/overlays/strimzi-0.45.x)
* [strimzi-0.46.x](operator/overlays/strimzi-0.46.x)
* [strimzi-0.47.x](operator/overlays/strimzi-0.47.x)
* [strimzi-0.48.x](operator/overlays/strimzi-0.48.x)
* [strimzi-0.49.x](operator/overlays/strimzi-0.49.x)
* [strimzi-0.50.x](operator/overlays/strimzi-0.50.x)
* [strimzi-0.51.x](operator/overlays/strimzi-0.51.x)
* [strimzi-1.x](operator/overlays/strimzi-1.x)
* [strimzi-1.0.x](operator/overlays/strimzi-1.0.x)
* [strimzi-1.1.x](operator/overlays/strimzi-1.1.x)
* [strimzi-1.2.x](operator/overlays/strimzi-1.2.x)

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
