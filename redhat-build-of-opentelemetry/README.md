# Red Hat build of OpenTelemetry

Red Hat build of OpenTelemetry is a collection of tools, APIs, and SDKs. You use it to instrument, generate, collect, and export telemetry data (metrics, logs, and traces) for analysis in order to understand your software's performance and behavior. This operator was previously called Red Hat OpenShift distributed tracing data collection.

# Install Red Hat build of OpenTelemetry by Red Hat.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [stable](operator/overlays/stable)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Red Hat build of OpenTelemetry Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k redhat-build-of-opentelemetry/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/redhat-build-of-opentelemetry/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/redhat-build-of-opentelemetry/operator/overlays/<channel>?ref=main
```
