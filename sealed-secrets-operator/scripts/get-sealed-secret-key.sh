#!/bin/bash
echo "Getting public key from Sealed Secrets secret and copying it to ~/bitnami"
echo "Create dir for Sealed Secrets public key. (~/bitnami)."
mkdir -p ~/.bitnami
echo "Backup secret itself"
oc get secret -o yaml -n sealed-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key=active > ~/.bitnami/sealed-secrets-secret.yaml
echo "Get the public key from the Sealed Secrets secret."
oc get secret -o yaml -n sealed-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key=active | grep tls.crt | cut -d' ' -f6 | base64 --decode > ~/.bitnami/publickey.pem