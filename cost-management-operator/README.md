# Koku Cost Management Operator

This deploys the Koku cost management operator into an OpenShift cluster. This operator uploads metrics to the cost management at cloud.redhat.com to enable cluster administrators to apply cost models and understand the cost impacts of resource utilization in the cluster.

## Deploying

To use the Operator you first need to setup a source in cloud.redhat.com. This can be done by going to Settings - Sources and clicking the Add Source button. Once you have done that you need to patch the KokuMetricsConfig to refer to this source, see the example overlay which shows how to do this using a fictitious source named 'Home'.
