# Contributions Guidelines

Contributions are welcome from all, here are quick notes on the structure and things to avoid when contributing.

## Folder and File Structure

In general the root folder should represent the functionality being provided with additional folders splitting the functionality as necessary. For example, many operators require that an operator subscription be created followed by an instance. In this case the following structure woule be used:

```
<name>-operator/
├── operator/
│   ├── base/
│   └── overlays/
│       ├── channelA/
│       └── channelB/
└── instance/
│   ├── base/
│   └── overlays/
│       └── default/
```

Overlays for operators should generally use the `channel` name as the name of the overlay if multiple channels are available. For example, if the channel names are `tech-preview` and `stable` then name the overlays the same corresponding to the channels.

When adding new objects into an example, avoid combining objects into a single yaml file.  Each object should have its own yaml file that is referenced as a resource in the `kustomization.yaml` file.  Some exceptions may exist, such as combining `role` and `roleBinding` into a sinlge RBAC file.  

Files in this repository should use the `.yaml` extension and not `.yml`.  Kustomize files should utilize `kustomization.yaml` over alternative naming options.

## Operator Recommendations

When adding operators please do *not* include `startingCSV` in the subscription unless there is a compelling reason to do so. The Operator Lifecycle Manager (OLM) will automatically use the latest version when `startingCSV` is not specified, including it places additional maintenance burdens in keeping it up to date.

When adding an operator that expects to run in its own unique namespace, a namespace and operatorGroup object should be included in the base folder for the operator.  If the operator is expected to run in a common namespace such as `openshift-operators` an operatorGroup should not be included.  OperatorGroup is required by OLM to install an operator in a namespace, however, if multiple operatorGroups exist in a single namespace all operator installs and upgrades will fail.

When adding an operatorGroup to an example, do *not* include the `olm.providedAPIs` annotation:

```
metadata:
  annotations:
    olm.providedAPIs:
```

The `olm.providedAPIs` annotation is automatically added by OLM once a subscription has been installed.  Including this annotation may cause reconciliation loops when utilizing these examples with GitOps tools such as ArgoCD.
