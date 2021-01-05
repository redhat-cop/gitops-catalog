This is an example of how to deploy grafana against the user-app monitoring feature in OpenShift. This example:

1. Deploys a namespace called user-grafana
2. Patches the grafana SAR so that a user must have at least view access on the grafana route to use grafana
3. Patches the clusterrolebinding for the namespace
