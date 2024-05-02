# devspaces

A collaborative Kubernetes-native development solution that delivers OpenShift workspaces and in-browser IDE for rapid cloud application development.
This operator installs PostgreSQL, Plugin and Devfile registries, Dashboard, Gateway and the Red Hat OpenShift Dev Spaces server, as well as configures all these services.
OpenShift OAuth is used directly for authentication. TLS mode is on.

## How to Install
Press the **Install** button, choose the channel and the upgrade strategy, and wait for the **Installed** Operator status.
When the operator is installed, create a new Custom Resource (CR) of Kind CheCluster (click the **Create New** button).
The CR spec contains all defaults. You can start using Red Hat OpenShift Dev Spaces when the CR status is set to **Available**, and you see a URL to Red Hat OpenShift Dev Spaces.

## Defaults
By default, the operator deploys Red Hat OpenShift Dev Spaces with:
* 10Gi storage
* Auto-generated passwords
* Bundled PostgreSQL
* Bundled Plugin and Devfile registries

Use `oc edit checluster/eclipse-che -n eclipse-che` to update Red Hat OpenShift Dev Spaces default installation options.
See more in the [Installation guide](https://www.eclipse.org/che/docs/che-7/installation-guide/configuring-the-che-installation/).

### Certificates
Operator uses a default router certificate to secure Red Hat OpenShift Dev Spaces routes.
Follow the [guide](https://www.eclipse.org/che/docs/che-7/installation-guide/importing-untrusted-tls-certificates/)
to import certificates into Red Hat OpenShift Dev Spaces.
