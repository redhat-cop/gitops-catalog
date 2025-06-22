# Zero Trust Workload Identity Manager

The Zero Trust Workload Identity Manager leverages Secure Production Identity Framework for Everyone (SPIFFE) and the SPIFFE Runtime Environment (SPIRE) to provide a comprehensive identity management solution for distributed systems. SPIFFE and SPIRE provide a standardized approach to workload identity, allowing workloads to communicate with other services whether on the same cluster, or in another environment.

## Zero Trust Workload Identity Manager Operator

Install The Zero Trust Workload Identity Manager Operator by Red Hat with content in the [operator](operator) directory.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [tech-preview](operator/overlays/tech-preview)

### Usage

If you have cloned the `gitops-catalog` repository, you can install the Zero Trust Workload Identity Manager Operator based on the overlay of your choice by running from the root (`gitops-catalog`) directory.

```
oc apply -k zero-trust-workload-identity-manager/operator/overlays/<channel>
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/zero-trust-workload-identity-manager/operator/overlays/<channel>
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/zero-trust-workload-identity-manager/operator/overlays/<channel>?ref=main
```

## Deploy an Instance of Zero Trust Workload Identity Manager

Once the Operator has been installed, an instance of Zero Trust Workload Identity Manager can be deployed. The content is available within the [instance](instance) directory. Similar to the _operator_ deployment described in the prior section, it is not recommended to use the `base` directory, and instead use the contents in the `overlays/default` directory.

### Usage

The default instance enables the configuration of both the `trustDomain` and `clusterName` fields that are present across multiple Custom Resources associated with the Zero Trust Workload Identity Manager. Update either of these values as desired within the `patches` section of the [kustomization.yaml](instance/overlays/default/kustomization.yaml) file within the `instance/overlays/default` directory.

The instance can be installed by running the following command from the root of the `gitops-catalog` directory.

```
oc apply -k zero-trust-workload-identity-manager/instance/overlays/default
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/zero-trust-workload-identity-manager/instance/overlays/default
```


As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/zero-trust-workload-identity-manager/instance/overlays/default?ref=main
```

## Aggregation of Operator and Instance

An aggregation to install both the Operator and Instance of Zero Trust Workload Identity Manager using a tool like Argo CD is contained  within the [aggregate](aggregate) directory. This enables a simple method of deploying both components in one shot.
