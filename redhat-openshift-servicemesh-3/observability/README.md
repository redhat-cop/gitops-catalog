# OpenShift ServiceMesh 3 - Observability

Sets up [observability for OpenShift Service Mesh 3](https://docs.redhat.com/en/documentation/red_hat_openshift_service_mesh/3.0/html/observability/ossm-observability-service-mesh).

## Prerequisites

First, install the following operators in your cluster:

- [OpenShift ServiceMesh Operator 3](../operator)
- [Kiali Operator](../../kiali-operator)

Then, install the Service Mesh 3 control plane:
- [OpenShift ServiceMesh Operator 3 - Control Plane](../instance)

Ensure that [User Workload Monitoring](https://docs.redhat.com/en/documentation/openshift_container_platform/4.19/html/monitoring/configuring-user-workload-monitoring) is configured for your cluster.

Do not use the `base` directory directly, use an overlay based on the observability configuration you need.

The current *overlays* available are:
* [default](overlays/default) - Deploys Kiali and the OSSM console plugin (no tracing)

## Usage

If you have cloned the `gitops-catalog` repository, you can install observability components by running from the root `gitops-catalog` directory

```
oc apply -k redhat-openshift-servicemesh-3/observability/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/redhat-openshift-servicemesh-3/observability/overlays/default
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/redhat-openshift-servicemesh-3/observability/overlays/default?ref=main
```

## Monitoring Additional Namespaces

For additional namespaces to show up in Kiali/OSSM Console, you must deploy a [`PodMonitor`](components/namespace-monitor/pod-monitor.yaml) to each namespace.

This can be deployed as part of an overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: my-app-namespace

components:
  - github.com/redhat-cop/gitops-catalog/redhat-openshift-servicemesh-3/observability/components/namespace-monitor?ref=main
```
