# Red Hat Service Interconnect (Skupper)

Install Red Hat Service Interconnect (Skupper) Operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [alpha](operator/overlays/alpha)
* [stable](operator/overlays/stable)
* [stable-1](operator/overlays/stable-1)
* [stable-1.4](operator/overlays/stable-1.4)
* [stable-1.5](operator/overlays/stable-1.5)
* [stable-1.8](operator/overlays/stable-1.8)
* [stable-1.9](operator/overlays/stable-1.9)
* [stable-2](operator/overlays/stable-2)
* [stable-2.0](operator/overlays/stable-2.0)
* [stable-2.1](operator/overlays/stable-2.1)
* [stable-2.2](operator/overlays/stable-2.2)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat OpenShift Dev Spaces based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k service-interconnect-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/service-interconnect-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/service-interconnect-operator/operator/overlays/<channel>?ref=main
```
