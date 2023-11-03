# Elastic Cloud on Kubernetes Operator

Install Elastic Cloud on Kubernetes (ECK) Operator to support the setup and management of Elasticsearch, Kibana, APM Server, Enterprise Search, Beats, Elastic Agent, Elastic Maps Server, and Logstash.

The current *overlays* available are for the following channels:

* [stable](overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install the ECK operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k eck-operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/eck-operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/eck-operator/overlays/<channel>?ref=main
 ```
