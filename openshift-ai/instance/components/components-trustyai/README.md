# components-trustyai

## Purpose
This component is designed help XAI explanations of predictive models.
The TrustyAI Components are Generally Available as of RHOAI 2.15.

## Usage

This component can be added to a base by adding the `components` section to your overlay `kustomization.yaml` file:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/components-trustyai
```
