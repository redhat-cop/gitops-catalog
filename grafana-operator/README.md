# Grafana

This installs the grafana operator along with an instance of grafana for application monitoring. The base is split into folders, one for the operator and another for the actual grafana instance. If you haven't installed grafana before you need to install the operator first so the CRDs are added before deploying the instance.

These bases cannot be deployed directly into a cluster, a a minimum you will need an overlay that creates a Namespace and an OperatorGroup, see the example overlay. Note only one OperatorGroup per namespace is permitted by OpenShift.

## Overlays

Two overlays are provided. The aggregate overlay deploys the operator and CR together, it relies on an ArgoCD feature to retry failures until the operator CRD has been created which it why it can be deployed together.

An example overlay shows how to use it in your projects and handle the namespace and operator group.