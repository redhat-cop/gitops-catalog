# OpenShift ServiceMesh 3 - Control Plane

Deploys an Istio control plane and CNI using the OpenShift Service Mesh Operator 3.

A cluster wide control plane is deployed in the `istio-system` namespace and the CNI is deployed in `istio-cni`.

Namespaces with the `istio-discovery: enabled` label will be part of the cluster wide mesh.

This deployment will require modification if migrating from Service Mesh 2 to 3. For information on migrating from Service Mesh 2 to 3, see this [documentation](https://docs.redhat.com/en/documentation/red_hat_openshift_service_mesh/3.0/html/migrating_from_service_mesh_2_to_service_mesh_3).

The `InPlace` upgrade strategy is used for Istio in this deployment.

## Prerequisites

First, install the following operators in your cluster:

- [OpenShift ServiceMesh Operator 3](../operator)

Review the [Service Mesh Install](https://docs.redhat.com/en/documentation/red_hat_openshift_service_mesh/3.0/html/installing/index) documentation.

Do not use the `base` directory directly, as you will need to patch the `version` based on the version of Istio you would like to deploy.

The current *overlays* available are:
* [v1.24-latest](overlays/v1.24-latest)
* [v1.24.5](overlays/v1.24.5)
* [v1.24.4](overlays/v1.24.4)
* [v1.24.3](overlays/v1.24.3)

## Usage

If you have cloned the `gitops-catalog` repository, you can install Istio by running from the root `gitops-catalog` directory

```
oc apply -k servicemeshoperator3/instance/overlays/<version>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/servicemeshoperator3/instance/overlays/<version>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/servicemeshoperator3/instance/overlays/<version>?ref=main
```
