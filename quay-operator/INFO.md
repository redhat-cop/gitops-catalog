# quay-operator

The Red Hat Quay Operator deploys and manages a production-ready
[Red Hat Quay](https://www.openshift.com/products/quay) private container registry.
This operator provides an opinionated installation and configuration of Red Hat Quay.
All components required, including Clair, database, and storage, are provided in an
operator-managed fashion. Each component may optionally be self-managed.

## Operator Features

* Automated installation of Red Hat Quay
* Provisions instance of Redis
* Provisions PostgreSQL to support both Quay and Clair
* Installation of Clair for container scanning and integration with Quay
* Provisions and configures RHOCS for supported registry object storage
* Enables and configures Quay's registry mirroring feature

## Prerequisites

By default, the Red Hat Quay operator expects RHOCS to be installed on the cluster to
provide the _ObjectBucketClaim_ API for object storage. For instructions installing and
configuring the RHOCS Operator, see the "Enabling OpenShift Container Storage" in the
[official documentation](https://access.redhat.com/documentation/en-us/red_hat_quay/3/html-single/deploy_red_hat_quay_on_openshift_with_the_quay_operator/index#enabling_openshift_container_storage).

## Simplified Deployment

The following example provisions a fully operator-managed deployment of Red Hat Quay,
including all services necessary for production:

```
apiVersion: quay.redhat.com/v1
kind: QuayRegistry
metadata:
  name: my-registry
```

## Documentation

See the
[official documentation](https://access.redhat.com/documentation/en-us/red_hat_quay/3/html/deploy_red_hat_quay_on_openshift_with_the_quay_operator/index)
for more complex deployment scenarios and information.