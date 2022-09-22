#!/bin/bash

KEY_DIR=~/.bitnami

echo "Getting public key from Sealed Secrets secret and copying it to ~/.bitnami"

[ -d "${KEY_DIR}" ] || mkdir -p "${KEY_DIR}"

echo "Dump sealed secrets"
oc get secret -l sealedsecrets.bitnami.com/sealed-secrets-key=active -n sealed-secrets -o yaml >  ~/.bitnami/sealed-secrets-secret.yaml

echo "Get the public key from the Sealed Secrets secret."
NUM=$(oc get secret -l sealedsecrets.bitnami.com/sealed-secrets-key=active -n sealed-secrets -o name | wc -l)
if [ "${NUM}" -gt "1" ]; then
  echo "WARNING: More than 1 sealed secret keyset. Exit"
  exit 1
else
  oc -n sealed-secrets \
    get secret \
    -l sealedsecrets.bitnami.com/sealed-secrets-key=active \
    -o jsonpath='{.items[0].data.tls\.crt}' | base64 --decode > ~/.bitnami/publickey.pem
fi
