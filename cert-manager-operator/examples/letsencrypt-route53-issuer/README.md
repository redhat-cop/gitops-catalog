This is an example issuer that uses letsencrypt (i.e. ACME) with a DNS challenge in AWS Route53. This example is useful when using AWS Route 53 as your DNS authority for OpenShift whether on-prem (like in my homelab) or in AWS itself. Documentation on Route 53 and cert-manager can be found here:

https://cert-manager.io/docs/configuration/acme/dns01/route53/#creating-an-issuer-or-clusterissuer

In order to this you need to update the staging and production letsencrypt issuers with the following information:

* The email that you use with letsencrypt
* The DNS Zone selector that is being managed by Route 53 that this issuer should be tied to (set to example.com here)
* The region that is being used
- The Access ID for the user in AWS that has permissions to work with Route 53, see the linked docs for IAM permissions required. This should absolutely not be the root AWS user

You will also need to create a secret to hold the AWS secret key corresponding to the access ID provided:

```
oc create secret generic letsencrypt-aws --from-literal=secret-access-key=XXXXXXXX
```

Obviously from a GitOps perspective this secret needs to be stored securely using something like Sealed Secrets or Vault.