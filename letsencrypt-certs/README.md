# Let's Encrypt Cluster Certificates

**Version: 0.1**

## Project Reference

GitHub: [OpenShift Let's Encrypt Job](https://github.com/pittar/ocp-letsencrypt-job)

## Usage

This currently is AWS-only, however, it should be relatively easy to expand to Azure (and likely other clouds).

This job requires an AWS IAM user with Route53 access.  It expects these credentials in the form of two environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

This `Job` will inject these values from a `Secret` with the name `cloud-dns-credentials` and keys of the same names.  However, since it's a really bad idea to put a plain k8s `Secret` in a git repository, you will want to use [Sealed Secrets](https://github.com/redhat-canada-gitops/catalog/tree/unify/sealed-secrets);