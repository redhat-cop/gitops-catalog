# idle-notebook-culling

## Purpose
This component is designed help admins configure the default PVC size that users are presented with when creating new Workbenches.

For more information see the official docs for [Stopping Idle Notebooks](https://access.redhat.com/documentation/en-us/red_hat_openshift_ai_self-managed/2-latest/html/managing_resources/managing-notebook-servers_notebook-mgmt#stopping-idle-notebooks_notebook-mgmt)

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/idle-notebook-culling
```

You can customize the time notebooks can remain running while inactive by updating the [culler-config.yaml](./culler-config.yaml) file.
