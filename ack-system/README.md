# AWS Controller for Kubernetes (ACK) EC2 Operator

Installs the ACK operators.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

NOTICE - !!! ACK Controllers are ALPHA !!!

The current *options* available are for the following:
* [overlays/aws-ops](overlays/aws-ops) - allows you to manage AWS services from `aws-ops` namespace
* [aggregate/popular](aggregate/popular) - installs the most popular ack controllers
* [overlays/default](overlays/default) - doesn't really do anything

## Usage

If you have cloned the `gitops-catalog` repository, you can install the ACK operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k ack-controllers/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/ack-controllers/overlays/aws-ops
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/redhat-cop/gitops-catalog/ack-controllers/overlays/aws-ops?ref=main
```

## Setup

See [Setup](SETUP.md)