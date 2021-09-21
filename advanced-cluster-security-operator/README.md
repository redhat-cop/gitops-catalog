### Introduction

This folder installs the Red Hat Advanced Cluster Security operator into a cluster. It installs both Central as well as the SecureCluster with the sensors.

### Install with Kustomize

To install the operator and instance using kustomize, first install the operator as follows:

```
oc apply -k advanced-cluster-security-operator/operator/overlays/latest
```

Once the operator is running in `openshift-operators` you can then install an instance with the following command:

```
oc apply -k advanced-cluster-security-operator/instance/overlays/default
```

This will create a `stackrox` namespace and install `central` as well as a the `securedcluster`. Stackrox requires a cluster-init bundle to be deployed to link the two, a job will run to do this. If for some reason you do not see data in ACS and no cluster appears in the Settings check the job logs to see what happened.

### Install with Argo CD

There is an aggregate overlay for use with Argo CD that uses sync waves to push things out in order. For the sync wave to work you will need to add a health check for Central in the resources section of your configuration as follows:

```
platform.stackrox.io/Central:
  health.lua: |
    hs = {}
    if obj.status ~= nil and obj.status.conditions ~= nil then
      for i, condition in ipairs(obj.status.conditions) do
        if condition.status == "True" and (condition.reason == "InstallSuccessful" or condition.reason =="UpgradeSuccessful") then
          hs.status = "Healthy"
          hs.message = condition.message
          return hs
        end
      end
    end
    hs.status = "Progressing"
    hs.message = "Waiting for Central to deploy."
    return hs
```

A minimal overlay suitable for demos is also available at `advanced-cluster-security-operator/aggregate/minimal`, note this should never be used in production.