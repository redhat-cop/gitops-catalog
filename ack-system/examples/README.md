# Adopting AWS resources into k8s / OpenShift

In some cases you want to manage a pre-existing resource that already exists in AWS. You can "adopt" that resource. This allows the ACK operator to create a CR for the object.

Example:

A preexisting S3 bucket called `sagemaker-fingerprint-data` exists in AWS.

When trying to create a `Bucket` CR in k8s / OpenShift the following error appears:

```
Status:
ACK.Terminal

This resource already exists but is not managed by ACK. To bring the resource under ACK management, you should explicitly adopt the resource by creating a services.k8s.aws/AdoptedResource
```

Steps to resolve:

1. Delete the `Bucket` CR in the `ACK.Terminal` state
1. Create an `AdoptedResource` - See: [Example](adopt-sagemaker-fingerprint-data-cr.yml)
1. S3 ACK Operator creates `Bucket` CR from existing resource in AWS

## Notes

**!!! WARNING !!!**

## *2023-01-11*

Once a resource in AWS has been `adopted` into a CR, deleting the
`AdoptedResource` triggers no action from the ACK operator.

The only safe way to remove an adopted CR *WITHOUT DELETING THE AWS
RESOURCE* is to remove the finalizer
from the CR, and hope deleting the CR doesn't cause the operator
to delete your AWS resource.

The assumption appears to be...

Once a resource is `adopted` it will only
be managed in k8s / OpenShift via the CR. No manual changes outside of
k8s / OpenShift appear to sync to the CR (ex: tags) via the operator.

Any changes outside of k8s / OpenShift will be overwritten by the CR.

Good Luck!

```
metadata:
  # delete the following 2 lines
  # before deleting the CR
  finalizers:
    - finalizers.s3.services.k8s.aws/Bucket
...
```

## Links

- <https://aws-controllers-k8s.github.io/community/docs/user-docs/adopted-resource>
