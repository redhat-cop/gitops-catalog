This is an example of how to deploy grafana against the user-app monitoring feature in OpenShift. This example:

1. Deploys a namespace called user-grafana
2. Patches the grafana SAR so that a user must have at least view access on the grafana route to use grafana
3. Patches the clusterrolebinding for the namespace

Note that if you want to deploy grafana in multiple namesaces you must the patch the ClusterRoleBindings for cluster-monitoring-view and grafana-proxy so they are unique. My recommendation is to suffix the name with the namespace as per the example here.