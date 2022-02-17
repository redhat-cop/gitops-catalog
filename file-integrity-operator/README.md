# OpenShift File Integrity Operator

## Usage

This is to deploy the [File Integrity Operator](https://docs.openshift.com/container-platform/latest/security/file_integrity_operator/file-integrity-operator-understanding.html) into an OpenShift 4.7 or later cluster. This operator continually runs file integrity checks on the cluster nodes.

## Install Operator Only

Reference on of the `operator/overlay` directories.  For example:

```
oc apply -k file-integrity-operator/operator/overlays/release-0.1
```

Or as part of your own `kustomization.yaml` file:

```yaml
kind: Kustomization
apiVersion: kustomize.config.k8s.io/v1beta1

bases:
- github.com/redhat-cop/gitops-catalog/file-integrity-operator/operator/overlays/release-0.1?ref=main
```

## Configure File Integrity Scans

File integrity scans are configured with the `FileIntegrity` CR. You can try one of the samples available in the `instance/overlays` directory.

