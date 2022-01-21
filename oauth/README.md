# Configuring Identity Providers

Do not use the `base` directory directly, as you will need to patch the `oauth` and add files to generate secrets.

The current *overlays* available are for the following providers:
* [htpasswd](overlays/htpasswd)

## Prerequisites

### For HTPasswd

> There is an existent file `users.htpasswd` with a single user `admin:redhat` in case you want to use it for testing purposes.

Have access to the `htpasswd` utility. On Red Hat Enterprise Linux this is available by installing the `httpd-tools` package.

Create or update your flat file with a user name and hashed password:

```shell
$ htpasswd -c -B -b users.htpasswd <user_name> <password>
```

Continue to add or update credentials to the file:

```shell
$ htpasswd -B -b users.htpasswd <user_name> <password>
```

Replace the default file of the provider overlay:

```shell
$ cp -f users.htpasswd gitops-catalog/oauth/overlays/htpasswd/files/
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

