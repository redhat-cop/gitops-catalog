# Configuring Identity Providers

Do not use the `base` directory directly, as you will need to patch the `oauth` and add files to generate secrets.

The current *overlays* available are for the following providers:
* [htpass-idp](overlays/htpass-idp)
* [htpass](overlays/htpass)
* [ldap](overlays/ldap)

## Prerequisites

### For HTPasswd

> There is an existent file `users.htpasswd` with a single user `admin:admin` in case you want to use it for testing purposes.

Have access to the `htpasswd` utility. On Red Hat Enterprise Linux this is available by installing the `httpd-tools` package.

Create or update your file with a user name and hashed password:

```shell
$ htpasswd -c -B -b users.htpasswd <user_name> <password>
```

Continue to add or update credentials to the file:

```shell
$ htpasswd -B -b users.htpasswd <user_name> <password>
```

Replace the default file of the provider overlay:

```shell
$ cp -f users.htpasswd gitops-catalog/oauth/overlays/htpass/files/
```

## Usage

If you have cloned the `gitops-catalog` repository, you can configure the identity provider based on the overlay of your choice by running from the root `gitops-catalog` directory.

```
oc apply -k oauth/overlays/<provider>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/oauth/overlays/<provider>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/oauth/overlays/<provider>?ref=main
```

### LDAP Example

It is assumed that the target Openshift environment already has the `secret/ldap-secret` and `configmap/ca-config-map` created.

Example overlay from another repo:

kustomization.yaml
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - github.com/redhat-cop/gitops-catalog/oauth/overlays/ldap?ref=main

generatorOptions:
  disableNameSuffixHash: true
  annotations:
    argocd.argoproj.io/sync-options: Prune=false
    argocd.argoproj.io/compare-options: IgnoreExtraneous

patchesJson6902:
  - target:
      group: config.openshift.io
      version: v1
      kind: OAuth
      name: cluster
    path: oauth-ldap-patch.yaml
```

oauth-ldap-patch.yaml
```
- op: replace
  path: /spec/identityProviders/0/ldap/url
  value: "ldap://ldap.example.com/ou=users,dc=acme,dc=com?uid"
- op: replace
  path: /spec/identityProviders/0/ldap/bindDN
  value: "ou=users,dc=examplecorp,dc=com"
```
