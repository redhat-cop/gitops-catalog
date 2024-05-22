# 1Password Connect and Operator

Installs 1Password [Connect](https://developer.1password.com/docs/connect/) and [Operator](https://developer.1password.com/docs/k8s/k8s-operator/).

Do not use the `base` directory directly, as you will need to create the appropriate Secrets. The current *overlays* available are:

* [default](aggregate/overlays/default)

## Usage

You need to create the following Secrets in the namespace where you want to install 1Password Connect and Operator:

- `onepassword-credentials`: A JSON file with the 1password credentials.
- `onepassword-token`: A file with the 1Password token.

You can create the Secrets as part of your own overlay, by using following `kustomization.yaml` file:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/redhat-cop/gitops-catalog/1password-connect/aggregate/overlays/default?ref=main

secretGenerator:
  - name: onepassword-credentials
    behavior: replace
    files:
      - 1password-credentials.json
  - name: onepassword-token
    behavior: replace
    envs:
      - onepassword-token.env

generatorOptions:
  disableNameSuffixHash: true
```

You need to execute this command to prepare the `1password-credentials.json` file:

```shell
cat original-1password-credentials.json | base64 | tr '/+' '_-' | tr -d '=' | tr -d '\n' > 1password-credentials.json
```

The `onepassword-token.env` file is an env file with the following content:

```ini
token=YOUR-1PASSWORD-TOKEN
```
