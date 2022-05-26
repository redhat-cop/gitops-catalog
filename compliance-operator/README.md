# OpenShift Compliance Operator

## Usage

This is to deploy the [Compliance Operator](https://docs.openshift.com/container-platform/latest/security/compliance_operator/compliance-operator-understanding.html) into an OpenShift 4.6 or later cluster. This operator
provides compliance scanning based on selectable set of rules.

## Install Operator Only

Reference on of the `operator/overlay` directories.  For example:

```
oc apply -k compliance-operator/operator/overlays/release-0.1?ref=main
```

Or as part of your own `kustomization.yaml` file:

```
kind: Kustomization
apiVersion: kustomize.config.k8s.io/v1beta1

bases:
- github.com/redhat-cop/gitops-catalog/compliance-operator/operator/overlays/release-0.1?ref=main
```

## Running Scans

If you would also like to run scans, you can try one of the sample scans available in the `instance/overlays` directory.

## All-in-One

If you would like to deploy the operator *and* run a scan all in one line, use on of the `aggregate` directories, for example:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/compliance-operator/aggregate/demo?ref=main
```
