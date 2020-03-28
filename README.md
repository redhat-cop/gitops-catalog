# Tools

Kustomize bases for various CI/CD Tools, including:
* Jenkins
* Nexus
* [SonarQube 8.2 Community](docs/sonarqube.md)
* Builds (skopeo Jenkins agent, Selenium Hub and agents)

## Setup

If you want to apply the base as is, you can simply clone the repo and run kustomize to add it to the current project/namespace:

```
git clone https://github.com/redhat-canada-gitops/10-devtools
oc apply -k nexus2/base
```

Or to skip the cloning step:

```
oc apply -k https://github.com/redhat-canada-gitops/10-devtools/nexus2/baseservice/nexus
```

## Kustomize

You can reference bases for the various tools here in your own kustomize overlay without explicitly cloning this repo, for example:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: product-catalog-cicd

bases:
- github.com/redhat-canada-gitops//nexus/bases/?ref=master
```

This enables you to patch these resources for your specific environments. Note that none of these bases specify a namespace, in your kustomization
overlay you can include the specific namespace you want to install the tool into.
