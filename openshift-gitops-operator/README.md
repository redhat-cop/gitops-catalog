# OpenShift GitOps Operator

Installs the OpenShift GitOps (Argo CD) operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [preview](overlays/preview)
* [stable](overlays/stable)
* [latest](overlays/latest)
* [gitops-1.5](overlays/gitops-1.5)

If you want to use the latest stable version of OpenShift GitOps, it is recommended that you use the `latest` channel.  If you want to stay on a particular release, please use the associated `gitops-1.x` channel.


## Usage

If you have cloned the `gitops-catalog` repository, you can install the OpenShift GitOps operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k openshift-gitops-operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-gitops-operator/overlays/<channel>
```
