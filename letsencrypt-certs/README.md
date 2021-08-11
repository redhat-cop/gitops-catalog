# Let's Encrypt Cluster Certificates

**Version: 0.1**

## Project Reference

GitHub: [OpenShift Let's Encrypt Job](https://github.com/pittar/ocp-letsencrypt-job)

## Usage

This currently is AWS-only, however, it should be relatively easy to expand to Azure (and likely other clouds).

This job requires an AWS IAM user with Route53 access.  It expects these credentials in the form of two environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

This `Job` will inject these values from a `Secret` with the name `cloud-dns-credentials` and keys of the same names.  However, since it's a really bad idea to put a plain k8s `Secret` in a git repository, you will want to use [Sealed Secrets](https://github.com/redhat-cop/gitops-catalog/tree/main/sealed-secrets-operator);

## Environment Variables

The job uses the following environment variables:

```
env:
  - name: STAGING
    value: 'false'
  - name: PATCH_API_SERVER
    value: 'false'
```

* **STAGING:** Set to `true` if you want to use Let's Encrypt `staging` functionality.  This will not actually create certificates, but can let you verify that your settings are correct without [exhausting your call limit to the Let's Encrypt service](https://letsencrypt.org/docs/staging-environment/).
* **PATCH_API_SERVER:** If set to `true`, then the OpenShift API Server certificate will also be updated. *Note:* It can take 5-10 minutes for the certificate to take effect for the API for some reason.  Be patient!
