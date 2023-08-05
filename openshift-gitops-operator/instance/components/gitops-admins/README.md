# gitops-admins

## Purpose
This component creates an empty gitops-admins group and configures the appropriate permissions in ArgoCD to grant that group admin permissions to ArgoCD.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/gitops-admins

patches:
  - path: gitops-admins-group.yaml
```

In addition, to adding the component, you will need to patch the gitops-admins group with a list of users to be added to the group:

```
kind: Group
apiVersion: user.openshift.io/v1
metadata:
  name: gitops-admins
users:
  - admin
  - opentlc-mgr
```
