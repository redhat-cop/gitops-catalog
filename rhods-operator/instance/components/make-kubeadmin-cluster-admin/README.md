# make-kubeadmin-cluster-admin

## Purpose
This component is designed to add kubeadmin as a Cluster Admin.  Out of the box, the Dashboard does not recognize kubeadmin as an admin user and does not have access to the Settings page.

For more information, see [this](https://github.com/opendatahub-io/odh-dashboard/issues/2006) upstream issue.

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
