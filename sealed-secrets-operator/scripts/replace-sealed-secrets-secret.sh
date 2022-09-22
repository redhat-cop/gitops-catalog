#!/bin/bash

echo "WARNING: Deleting existing secrets in 8 seconds..."
echo
oc get secret -n sealed-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key
sleep 8

oc delete secret -n sealed-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key
echo "Creating secret from local drive."
oc create -f ~/.bitnami/sealed-secrets-secret.yaml -n sealed-secrets
echo "Restarting Sealed Secrets controller."
oc delete pod -l name=sealed-secrets-controller -n sealed-secrets
