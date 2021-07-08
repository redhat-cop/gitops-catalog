#!/bin/bash

find -type f -name "kustomization.yaml" -print0 | while read -d $'\0' file
do
    dir=$(dirname "$file")
    echo "Testing ${dir}"
    kustomize build "${dir}"
done

./openshift-serverless-knative-eventing/overlays/knative-kafka