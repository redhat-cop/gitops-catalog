# Cluster Observability Operator

Cluster Observability Operator is a Go based Kubernetes operator to setup and manage highly available Monitoring stack using Prometheus, Alertmanager and Thanos Querier.

# Cluster Observability Operator

Install Cluster Observability Operator by Red Hat.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [development](operator/overlays/development)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Cluster Observability Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k cluster-observability-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/cluster-observability-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/cluster-observability-operator/operator/overlays/<channel>?ref=main
```
