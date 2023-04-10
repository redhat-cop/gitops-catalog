# openshift-gitops-operator

Red Hat OpenShift GitOps is a declarative continuous delivery platform based on [Argo CD](https://argoproj.github.io/argo-cd/). It enables teams to adopt GitOps principles for managing cluster configurations and automating secure and repeatable application delivery across hybrid multi-cluster Kubernetes environments. Following GitOps and infrastructure as code principles, you can store the configuration of clusters and applications in Git repositories and use Git workflows to roll them out to the target clusters.

## Features

* Automated install and upgrades of Argo CD
* Manual and automated configuration sync from Git repositories to target OpenShift and Kubernetes clusters
* Support for the Helm and Kustomize templating tools
* Configuration drift detection and visualization on live clusters
* Audit trails of rollouts to the clusters
* Monitoring and logging integration with OpenShift
* Automated GitOps bootstrapping using Tekton and Argo CD with [GitOps Application Manager CLI](https://github.com/redhat-developer/kam)

## Components

* Argo CD v2.1.16
* GitOps Application Manager CLI ([download](https://github.com/redhat-developer/kam/releases))

## How to Install

After installing the OpenShift GitOps operator, an instance  of Argo CD is installed in the `openshift-gitops` namespace which has sufficent privileges for managing cluster configurations. You can create additional Argo CD instances using the `ArgoCD` custom resource within the desired namespaces.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
spec:
  server:
    route:
      enabled: true
```

OpenShift GitOps is a layered product on top of OpenShift that enables teams to adopt GitOps principles for managing cluster configurations and automating secure and repeatable application delivery across hybrid multi-cluster Kubernetes environments. OpenShift GitOps is built around Argo CD as the core upstream project and assists customers to establish an end-to-end application delivery workflow on GitOps principles.
