# OpenShift Virtualization Operator

**Version: 0.1**

## Usage

This is to deploy [OpenShift Virtualization](https://docs.openshift.com/container-platform/4.5/virt/about-virt.html) into an OpenShift cluster. This operator
enables you to run virtual machines in an OpenShift cluster managed by the OpenShift control plane.

Note that this operator is only supported on bare metal deployments, for testing purposes the emulation overlay can be used to deploy on environments where OpenShift
is deployed in a virtual environment (AWS, libvirt, etc). This is strongly not recommended for production use cases.