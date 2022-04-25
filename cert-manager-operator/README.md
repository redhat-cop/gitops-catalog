### Introduction

This deploys the cert-manager operator which is currently Tech Preview in 4.10. If you are not familiar with cert-manager, it provisions and manages TLS certificates for you automatically using one or more configured Issuers. It's great for providing a self-service capability around TLS certificates out of the OpenShift platform.

Documentation on OpenShift cert-manager is available [here](https://docs.openshift.com/container-platform/4.10/security/cert_manager_operator/index.html).

Community documentation for cert-manager is located [here](https://cert-manager.io/docs/).

### Examples

The examples folder contains some examples of how to use cert-manager including how to use it to provision OpenShift API and Wildcard certificates. There is a README associated with each example when you navigate to each folder.

### TODO

At some point I would like to make the examples directly deployable via a Helm chart. The examples are a case which would benefit from Helm templating versus patching in kustomize since many of the values can be derived from two parameters: cluster name and domain.