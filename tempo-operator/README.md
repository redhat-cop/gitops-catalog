# Tempo Operator

Red Hat OpenShift distributed tracing platform based on Tempo. Tempo is an open-source, easy-to-use, and highly scalable distributed tracing backend. It provides observability for microservices architectures by allowing developers to track requests as they flow through distributed systems. Tempo is optimized to handle large volumes of trace data and is designed to be highly performant even under heavy loads. It can ingest common open source tracing protocols including Jaeger, Zipkin, and OpenTelemetry and requires only object storage to operate.

# Tempo Operator

Install Tempo Operator by Red Hat.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Tempo Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k tempo-operator/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/tempo-operator/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/tempo-operator/operator/overlays/<channel>?ref=main
```
