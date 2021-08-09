# GitOps Catalog

The GitOps Catalog includes kustomize bases and overlays for a number of OpenShift operators and applications.

This catalog is not officially supported by Red Hat and customers are discouraged from referencing this repo directly as a remote repo in kustomize as future changes may break these references. Instead customers are encouraged to take individual items of interest into their own curated catalog and maintain it as their own.

## Usage

Each catalog item has (or will have) its own README in its directory root with instructions.  Generally speaking, you can usually just apply a "base" or "overlay" directly in your cluster by cloning this repostitory and using the `-k` flag (for Kustomize) built into `oc` and `kubectl`:

```
git clone https://github.com/redhat-canada-gitops
oc apply -k catalog/jenkins2/overlays/default
```

Or to skip the cloning step:

```
oc apply -k https://github.com/redhat-canada-gitops/catalog/jenkins2/overlays/default
```

## Kustomize

You can reference bases for the various tools here in your own kustomize overlay without explicitly cloning this repo, for example:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: product-catalog-cicd

resources:
- github.com/redhat-canada-gitops/catalog/jenkins2/bases/?ref=master
```

This enables you to patch these resources for your specific environments. Note that none of these bases specify a namespace, in your kustomization
overlay you can include the specific namespace you want to install the tool into.
