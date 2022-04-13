This is an example of using cert-manager to generate a TLS certificate for the Red Hat Advanced Cluster Security Central endpoint (i.e. `central-stackrox.<cluster>.<domain>.com`).

To use this, update the certificate object to reflect your desired issuer and host name for the API endpoint. In the example we are using the letsencrypt-prod issuer in the examples folder.

Note the certificate will overwrite the existing default certificate so you may wish to back that up first before using this.