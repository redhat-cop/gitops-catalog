# openshift-ai

Red Hat OpenShift AI is a complete platform for the entire lifecycle of your AI/ML projects.

When using Red Hat OpenShift AI, your users will find all the tools they would expect from a modern AI/ML platform in an interface that is intuitive, requires no local install, and is backed by the power of your OpenShift cluster.

Your Data Scientists will feel right at home with quick and simple access to the Notebook interface they are used to. They can leverage the default Notebook Images (Including PyTorch, tensorflow, and CUDA), or add custom ones. Your MLOps engineers will be able to leverage Data Science Pipelines to easily parallelize and/or schedule the required workloads. They can then quickly serve, monitor, and update the created AI/ML models. They can do that by either using the provided out-of-the-box OpenVino Server Model Runtime or by adding their own custom serving runtime instead. These activities are tied together with the concept of Data Science Projects, simplifying both organization and collaboration.

But beyond the individual features, one of the key aspects of this platform is its flexibility. Not only can you augment it with your own Customer Workbench Image and Custom Model Serving Runtime Images, but you will also have a consistent experience across any infrastructure footprint. Be it in the public cloud, private cloud, on-premises, and even in disconnected clusters. Red Hat OpenShift AI can be installed on any supported OpenShift. It can scale out or in depending on the size of your team and its computing requirements.

Finally, thanks to the operator-driven deployment and updates, the administrative load of the platform is very light, leaving everyone more time to focus on the work that makes a difference.

### Components
* Dashboard
* Curated Workbench Images (including CUDA, PyTorch, TensorFlow, code-server, TrustyAI)
* Ability to add Custom Images
* Ability to leverage accelerators (such as NVIDIA GPU)
* Data Science Pipelines (including Elyra notebook interface)
* Model Serving using ModelMesh and KServe.
* Ability to use other runtimes for serving
* Model Monitoring
* Distributed workloads (KubeRay, CodeFlare, Kueue, Training Operator)
* XAI explanations of predictive models (TrustyAI)
* Index and manage models, versions, and artifacts metadata (Model Registry)
