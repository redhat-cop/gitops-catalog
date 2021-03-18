# Red Hat Migration Toolkit for Applictions

**DEPRECATED:** This needs to be updated to use the MTA Operator instead.

This deploys an instance of Red Hat MTA with default settings in the namespace `app-migration`.

## Deploying

The `base` directory has everything required for a default setup of Red Hat MTA, however, it does require that you pre-create a namespace (default being `app-migration`) or create a namespace in your own overlay.  You can create this in your own cluster with:

```
oc apply -k base
```

## Login

The default username and password for Migration Toolkit for Applications is `mta / password`.
