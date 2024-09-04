#!/bin/bash

import_der_from_url() {
  curl --silent --output "$1".der "$2"
  keytool -importcert -alias "$1" -noprompt -storetype jks -keystore truststore.jks -storepass changeit -file "$1".der
  rm "$1".der
}

rm -f truststore.jks

# List from:
# https://letsencrypt.org/docs/staging-environment/

import_der_from_url x1 https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x1.der

import_der_from_url x2 https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x2.der
import_der_from_url x2-cross https://letsencrypt.org/certs/staging/letsencrypt-stg-root-x2-signed-by-x1.der
