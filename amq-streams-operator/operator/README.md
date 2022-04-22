# AMQ Streams Operator

Installs the AMQ Streams operator into all namespaces.

Current channel overlays include:
* [amq-streams-1.x](overlays/1.x)
* [amq-streams-1.8.x](overlays/1.8.x)
* [amq-streams-2.x](overlays/2.x)
* [amq-streams-2.0.x](overlays/2.x)
* [amq-streams-2.1.x](overlays/2.x)
* [stable](overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the AMQ Streams operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k amq-streams-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/amq-streams-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/amq-streams-operator/operator/overlays/<channel>?ref=main
```