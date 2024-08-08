# default-notebook-pvc-size

## Purpose
This component is designed help admins configure the default PVC size that users are presented with when creating new Workbenches.


For more information see the official docs for [Configuring Default PVC size](https://access.redhat.com/documentation/en-us/red_hat_openshift_ai_self-managed/2-latest/html/managing_resources/managing-cluster-resources_cluster-mgmt#configuring-the-default-pvc-size-for-your-cluster_cluster-mgmt)


## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/default-notebook-pvc-size
```

You can customize the PVC size by updating the [patch-rhoai-dashboard.yaml](./patch-rhoai-dashboard.yaml) file.
