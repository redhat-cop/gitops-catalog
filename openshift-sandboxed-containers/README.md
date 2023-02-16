# OpenShift sandboxed containers

This kustomization installs the OpenShift sandboxed containers operator. The official documentation for the operator can be found [here](https://docs.openshift.com/container-platform/4.10/sandboxed_containers/understanding-sandboxed-containers.html).

OpenShift sandboxed containers requires OpenShift Container Platform >= 4.10.

Note that the operator will install a MachineConfig resource to enable the sandboxed containers extension on the cluster node. This will cause the cluster nodes to restart.

Do not use the `base` directory directly, as you will need to patch the `channel` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

* [preview-1.1](operator/overlays/preview-1.1)
* [stable-1.2](operator/overlays/stable-1.2)
* [stable-1.3](operator/overlays/stable-1.3)

## Usage

Install the OpenShift sandboxed containers operator:

```
$ oc apply -k oc apply -k operator/overlays/<channel>
```

Create cluster-wide kataconfig resource:

```
$ oc apply -k instance/base
```

Optionally, deploy a example workload that runs in a sandboxed container:

```
$ oc apply -k example-workload/base
```
