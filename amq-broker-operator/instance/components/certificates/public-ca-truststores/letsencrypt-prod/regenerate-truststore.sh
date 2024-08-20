#!/bin/bash

import_der_from_url() {
  curl --silent --output "$1".der "$2"
  keytool -importcert -alias "$1" -noprompt -storetype jks -keystore truststore.jks -storepass changeit -file "$1".der
  rm "$1".der
}

rm -f truststore.jks

# List from:
# https://letsencrypt.org/certificates/

import_der_from_url e5 https://letsencrypt.org/certs/2024/e5.der
import_der_from_url e5-cross https://letsencrypt.org/certs/2024/e5-cross.der

import_der_from_url e6 https://letsencrypt.org/certs/2024/e6.der
import_der_from_url e6-cross https://letsencrypt.org/certs/2024/e6-cross.der

import_der_from_url r10 https://letsencrypt.org/certs/2024/r10.der

import_der_from_url r11 https://letsencrypt.org/certs/2024/r11.der
