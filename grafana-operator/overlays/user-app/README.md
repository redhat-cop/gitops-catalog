Grafana instance that is to be used with the OpenShift user monitoring feature, it deploys:

1. A grafana datasource to connect to the OpenShift Monitoring Thanos instance
2. A job which patches the grafana datasource to include a token from the serviceaccount (declared as an ArgoCD resource hook)
3. A clusterrolebinding to enable the grafana-serviceaccount to connect to thanos, the namespace and name will need to be patched in downstream overlays. See the user-app-example for this.