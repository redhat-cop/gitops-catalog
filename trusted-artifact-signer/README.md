# Red Hat Trusted Artifact Signer

Red Hat Trusted Artifact Signer deploys a Sigstore signing service on OpenShift. The operator installs into `openshift-operators`. The signing service runs in the `trusted-artifact-signer` namespace.

Do not use the `operator/base` directory directly. Patch the channel with an overlay.

The current operator overlays are:

* [stable](operator/overlays/stable)
* [stable-v1.5](operator/overlays/stable-v1.5)

## Usage

Install the operator from the root of this repository:

```
oc apply -k trusted-artifact-signer/operator/overlays/stable
```

Or, without cloning:

```
oc apply -k https://github.com/redhat-cop/gitops-catalog/trusted-artifact-signer/operator/overlays/stable
```

As part of a different overlay in your own GitOps repo:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/redhat-cop/gitops-catalog/trusted-artifact-signer/operator/overlays/stable?ref=main
```

## Instance

The instance creates a `Securesign` resource. Replace `https://replace-with-your-oidc-issuer` with the issuer URL of your OpenID Connect provider before applying it. Fulcio will not issue certificates until that URL is a real issuer.

```
oc apply -k trusted-artifact-signer/instance/overlays/default
```
