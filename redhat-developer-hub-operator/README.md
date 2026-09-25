# Red Hat Developer Hub Operator

Red Hat Developer Hub is a Red Hat supported version of Backstage. It comes with pre-built plug-ins, configuration settings, and deployment mechanisms, which can help streamline the process of setting up a self-managed internal developer portal for adopters who are just starting out.

# Red Hat Developer Hub Operator

Install Red Hat Developer Hub Operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [fast](operator/overlays/fast)
* [fast-1.1](operator/overlays/fast-1.1)
* [fast-1.2](operator/overlays/fast-1.2)
* [fast-1.3](operator/overlays/fast-1.3)
* [fast-1.4](operator/overlays/fast-1.4)
* [fast-1.5](operator/overlays/fast-1.5)
* [fast-1.6](operator/overlays/fast-1.6)
* [fast-1.7](operator/overlays/fast-1.7)
* [fast-1.8](operator/overlays/fast-1.8)
* [fast-1.9](operator/overlays/fast-1.9)
* [fast-1.10](operator/overlays/fast-1.10)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat Developer Hub Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k redhat-developer-hub-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/redhat-developer-hub-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/redhat-developer-hub-operator/operator/overlays/<channel>?ref=main
```
