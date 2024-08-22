This is an example of using cert-manager to generate a root CA for signing certificates.

It works by creating a namespaced issuer (not ClusterIssuer) to generate the root certificate in the cert-manager
namespace. It then references the root certificate with a ClusterIssuer set to be a CA.