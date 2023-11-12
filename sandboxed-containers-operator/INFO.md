# sandboxed-containers-operator

# Requirements
Your cluster must be installed on bare metal infrastructure with Red Hat Enterprise Linux CoreOS workers.

# Details
OpenShift sandboxed containers based on the Kata Containers open source
project, provides an Open Container Initiative (OCI) compliant container
runtime using lightweight virtual machines, running your workloads in their own
isolated kernel and therefore contributing an additional layer of isolation
back to OpenShift’s Defense-in-Depth strategy. For more information
[see](https://catalog.redhat.com/software/operators/detail/5ee0d499fdbe7cddc2c91cf5).

# Features & benefits
- **Isolated Developer Environments & Priviliges Scoping**
  As a developer working on debugging an application using state-of-the-art
  tooling you might need elevated privileges such as CAP_ADMIN or CAP_BPF. With
  OpenShift sandboxed containers, any impact will be limited to a separate
  dedicated kernel.

- **Legacy Containerized Workload Isolation**
  You are mid-way in converting a containerized monolith into cloud-native
  microservices. However, the monolith still runs on your cluster unpatched and
  unmaintained. OpenShift sandboxed containers helps isolate it in its own kernel
  to reduce risk.

- **Safe Multi-tenancy & Resource Sharing (CI/CD Jobs, CNFs, ..)**
  If you are providing a service to multiple tenants, it could mean that the
  service workloads are sharing the same resources (e.g., worker node). By
  deploying in a dedicated kernel, the impact of these workloads have on one
  another is greatly reduced.

- **Additional Isolation with Native Kubernetes User Experience**
  OpenShift sandboxed containers is used as a compliant OCI runtime.
  Therefore, many operational patterns used with normal containers are still
  preserved including but not limited to image scanning, GitOps, Imagestreams,
  and so on.

# How to install
  Read the information about the Operator and click Install.

  On the Install Operator page:

  - Select preview-1.0 from the list of available Update Channel options.
  This ensures that you install the version of OpenShift sandboxed containers
  that is compatible with your OpenShift Container Platform version.

  - For Installed Namespace, ensure that the Operator recommended namespace
    option is selected. This installs the Operator in the mandatory
    openshift-sandboxed-containers-operator namespace, which is automatically
    created if it does not exist. Attempting to install the OpenShift
    sandboxed containers Operator in a namespace other than
    openshift-sandboxed-containers-operator causes the installation to fail.

  - For Approval Strategy, ensure that Automatic, which is the default value,
    is selected. OpenShift sandboxed containers automatically updates when a new
    z-stream release is available.

  - Click Install to make the Operator available to the OpenShift sandboxed
    containers namespace.

  - The OpenShift sandboxed containers Operator is now installed on your
    cluster. You can trigger the Operator by enabling the runtime on your cluster.
    You can do this by creating a KataConfig CRD instance. For this click
    on "create instance" on the operator overview page.

# Documentation
See the official documentation [here](https://docs.openshift.com/container-platform/4.8/sandboxed_containers/understanding-sandboxed-containers.html).