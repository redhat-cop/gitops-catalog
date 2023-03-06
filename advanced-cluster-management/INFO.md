# advanced-cluster-management

Red Hat Advanced Cluster Management for Kubernetes provides the multicluster hub, a central management console for managing multiple Kubernetes-based clusters across data centers, public clouds, and private clouds. You can use the hub to create Red Hat OpenShift Container Platform clusters on selected providers, or import existing Kubernetes-based clusters. After the clusters are managed, you can set compliance requirements to ensure that the clusters maintain the specified security requirements. You can also deploy business applications across your clusters.

Red Hat Advanced Cluster Management for Kubernetes also provides the following operators:

- Multicluster subscriptions: An operator that provides application management capabilties including subscribing to resources from a channel and deploying those resources on MCH-managed Kubernetes clusters based on placement rules.
- Hive for Red Hat OpenShift: An operator that provides APIs for provisioning and performing initial configuration of OpenShift clusters.
These operators are used by the multicluster hub to provide its provisioning and application-management capabilities.
## How to Install
Use of this Red Hat product requires a licensing and subscription agreement.

Install the Red Hat Advanced Cluster Management for Kubernetes operator by following instructions presented when you click the `Install` button. After installing the operator, create an instance of the `MultiClusterHub` resource to install the hub. Note that if you will be using the hub to manage non-OpenShift 4.x clusters, you will need to create a Kubernetes `Secret` resource containing your OpenShift pull secret and specify this `Secret` in the `MultiClusterHub` resource, as described in the install documentation.

You can find additional installation guidance in the [install documentation](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.4/html/install/installing). 