# opendatahub-operator

The Open Data Hub is a machine-learning-as-a-service platform built on Red Hat's Kubernetes-based OpenShift® Container Platform. Open Data Hub integrates multiple AI/ML open source components into one operator that can easily be downloaded and installed by OpenShift users.

Open Data Hub operator allows users to install and manage components of the Open Data Hub. Users can mix and match tools from each project to fulfill the needs of their use case. Each of the
projects share some components, but can be mostly seen as an extension of each other to provide a complete solution for both novice and skilled enterprise users.

### Components
* Open Data Hub Dashboard - A web dashboard that displays installed Open Data Hub components with easy access to component UIs and documentation
* ODH Notebook Controller - Secure management of Jupyter Notebook in Kubernetes environments built on top of Kubeflow Notebook Controller with support for OAuth
* Jupyter Notebooks - JupyterLab notebook that provide Python support for GPU workloads
* Data Science Pipelines - Pipeline solution for end to end MLOps workflows that support the Kubeflow Pipelines SDK and Tekton
* Model Mesh - ModelMesh Serving is the Controller for managing ModelMesh, a general-purpose model serving management/routing layer.

To install one or multiple of these components use the default KfDef provided with the operator.

NOTE: As of ODH 1.4, ODH has replaced JupyterHub multi-user server with ODH Notebook Controller for lifecycle management of Jupyter Notebook servers.  JupyterHub is still available for deployment but there will be no further updates and it will be officially deprecated with the release of ODH 1.5

### Available Channels

#### Stable

Channel `stable` offers the major releases of Open Data Hub operator and ODH manifests. It is based on Kubeflow Operator and Kustomize for deployment configuration. This version is compatible with [Open Data Hub manifests](https://github.com/opendatahub-io/odh-manifests/) as well as [Kubeflow manifests](https://github.com/opendatahub-io/manifests). This channel will offer new components and features that have been thoroughly tested by consumers of the `rolling` channel

#### Rolling

Channel `rolling` will offer the latest release of Open Data Hub operator and manifests. Subscribing to this branch will provide faster updates and access to components that will be in developement and testing for the next stable release
