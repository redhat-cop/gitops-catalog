# Tekton Resources - OpenShift Pipelines

The purpose of this repository is to create tasks that are re-usable, at least within the Red Hat Canada community :)

Many `ClusterTask`s that are provided out of the box are too rigid in their definition to be truely useful outside of basic pipeline configuration.  Generally, it seems to be difficult to create generic `Task`s that are reusable.

Based on work that intersects between the demos that we work on individually, we have started to catalog some `Task`s that seem to have a higher degree of reuse.

## Tasks: Vetted

These tasks are being used in at least two separate demos, proving at least a small degree of reuse:

* None

## Tasks: Work in Progress

This is the list of `Task`s that are a work in progress.  They are used in at least 1 demo currently.

* **Binary Build:** Start a "source-to-image" binary build.
* **.Net 5.0:** `dotnet` cli task.
* **Maven:** Based on the existing maven *ClusterTask*, but exteneded to reference a `Secret` that can hold *maven repository configuration* details, such as Nexus username and password, maven repo URL, etc...
* **Newman:** Run Newman tests.
* **Rollout Restart:** This takes the name and namespace of a `Deployment` as parameters and calls `oc rollout restart deployment <deployment name> -n <namespace>`, then calls `status` to follow deployment progress.
