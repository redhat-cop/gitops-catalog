# Tools

Kustomize bases for various CI/CD Tools, including:
* Jenkins
* Nexus
* SonarQube
* Builds (skopeo Jenkins agent, Selenium Hub and agents)

## Setup

If you want to apply the base as is, you can simply clone the repo and run kustomize to add it to the current project/namespace:

```
git clone https://github.com/redhat-canada-gitops/10-devtools
kustomize build nexus2/base | oc apply -f -

Or to skip the cloning step:

kustomize build github.com/redhat-canada-gitops/10-devtools//nexus2/base/?ref=master | oc apply -f -