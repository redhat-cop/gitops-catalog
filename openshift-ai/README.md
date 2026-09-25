# Red Hat OpenShift AI

Install Red Hat OpenShift AI.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [3.2-exception-support](operator/overlays/3.2-exception-support)
* [alpha](operator/overlays/alpha)
* [beta](operator/overlays/beta)
* [embedded](operator/overlays/embedded)
* [eus-2.8](operator/overlays/eus-2.8)
* [eus-2.16](operator/overlays/eus-2.16)
* [eus-2.25](operator/overlays/eus-2.25)
* [eus-3.5](operator/overlays/eus-3.5)
* [fast](operator/overlays/fast)
* [fast-3.x](operator/overlays/fast-3.x)
* [stable](operator/overlays/stable)
* [stable-2.8](operator/overlays/stable-2.8)
* [stable-2.10](operator/overlays/stable-2.10)
* [stable-2.13](operator/overlays/stable-2.13)
* [stable-2.16](operator/overlays/stable-2.16)
* [stable-2.19](operator/overlays/stable-2.19)
* [stable-2.22](operator/overlays/stable-2.22)
* [stable-2.25](operator/overlays/stable-2.25)
* [stable-3.x](operator/overlays/stable-3.x)
* [stable-3.3](operator/overlays/stable-3.3)
* [stable-3.4](operator/overlays/stable-3.4)
* [stable-3.5](operator/overlays/stable-3.5)
* [support-required-upgrade](operator/overlays/support-required-upgrade)
* [support-required-upgrade-3.5](operator/overlays/support-required-upgrade-3.5)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat OpenShift AI based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k openshift-ai/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-ai/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/openshift-ai/operator/overlays/<channel>?ref=main
```
