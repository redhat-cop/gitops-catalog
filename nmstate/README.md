# NMState

## Usage

This is to deploy [NMState operator](https://docs.openshift.com/container-platform/4.9/networking/k8s_nmstate/k8s-nmstate-about-the-k8s-nmstate-operator.html) to OpenShift. The NMState Operator provides users with functionality to configure various network interface types, DNS, and routing on cluster nodes

## Installation

Install the NMState operator:

```
$ oc apply -k nmstate/operator
```

Install cluster-wide NMState instance

```
$ oc apply -k nmstate/instance
```

Check that network state for the cluster nodes was created (see also [Viewing the network state of a node](https://docs.openshift.com/container-platform/4.9/networking/k8s_nmstate/k8s-nmstate-observing-node-network-state.html):

```
$ oc get nns
```
