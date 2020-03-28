# Argo CD Example

This example assumes Argo CD has the rights to create namespaces in your cluster.

If this is not the case, then pre-create the `sonarqube` namespace/project and delete `namespace.yaml` as well as the reference to it in `kustomization.yaml`.