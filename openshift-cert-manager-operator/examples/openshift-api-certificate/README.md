This is an example of using cert-manager to generate a TLS certificate for the OpenShift API endpoint (i.e. `api.<cluster>.<domain>.com`) and patching it using an Argo CD post-sync hook.

To use this, update the certificate object to reflect your desired issuer and host name for the API endpoint. In the example we are using the letsencrypt-prod issuer in the examples folder.