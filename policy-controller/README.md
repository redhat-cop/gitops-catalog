# Policy Controller

The Policy Controller is the admission controller used with Red Hat Trusted Artifact Signer. It checks container images against cluster image policies for signatures and attestations.

The operator installs into the `policy-controller-operator` namespace. Do not use the `operator/base` directory directly. Patch the channel with an overlay.

The current operator overlays are:

* [stable](operator/overlays/stable)
* [stable-v1.1](operator/overlays/stable-v1.1)
* [stable-v1.0](operator/overlays/stable-v1.0)

## Usage

Install the operator from the root of this repository:

```
oc apply -k policy-controller/operator/overlays/stable
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/policy-controller/operator/overlays/stable
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/policy-controller/operator/overlays/stable?ref=main
```

## Instance

Apply an operator overlay before the instance. The operator creates the `policy-controller-operator` namespace.

The instance creates a `PolicyController` resource in that namespace. That resource installs the admission controller. It checks only namespaces labeled `policy.rhtas.com/include=true`.

A cluster image policy is not included. It has to name the signing service from your Trusted Artifact Signer deployment. Apply one after that deployment exists, and only on the namespaces you want checked.

```
oc apply -k policy-controller/instance/overlays/default
```
