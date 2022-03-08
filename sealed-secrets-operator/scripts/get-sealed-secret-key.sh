#!/bin/bash
echo "Getting public key from Sealed Secrets secret and copying it to ~/.bitnami"
echo "Create dir for Sealed Secrets public key. (~/.bitnami)."
mkdir -m 700 -p ~/.bitnami
echo "Backup secret itself"
oc get secret -l sealedsecrets.bitnami.com/sealed-secrets-key=active -n sealed-secrets -o yaml >  ~/.bitnami/sealed-secrets-secret.yaml
echo "Get the public key from the Sealed Secrets secret."
oc get secret -l sealedsecrets.bitnami.com/sealed-secrets-key=active -n sealed-secrets -o jsonpath='{.data.tls\.crt}' | base64 --decode > ~/.bitnami/publickey.pem
