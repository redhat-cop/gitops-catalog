# AWS Controller for Kubernetes (ACK) EC2 Operator

Installs the ACK EC2 operator.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:
* [alpha](overlays/alpha)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the ACK EC2 operator based on the overlay of your choice by running from the root `gitops-catalog` directory

```
oc apply -k ack-ec2-controller/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/ack-ec2-controller/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/redhat-cop/gitops-catalog/ack-ec2-controller/operator/overlays/<channel>?ref=main
```