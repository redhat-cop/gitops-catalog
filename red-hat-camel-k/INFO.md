# red-hat-camel-k

Red Hat Integration - Camel K
==============

**Red Hat Integration - Camel K** is a lightweight integration platform, born on Kubernetes, with serverless superpowers.

## Installation

To start using Camel K, install the operator and then create the following `IntegrationPlatform`:
```
apiVersion: camel.apache.org/v1
kind: IntegrationPlatform
metadata:
  name: camel-k
  labels:
    app: "camel-k"
```

An `IntegrationPlatform` resource is automatically created by default, so you can skip this step.
Also, You can edit the `IntegrationPlatform`, to configure Camel K.
The configuration from the `IntegrationPlatform` will apply to the Camel integrations created in the same project.

## Running an Integration

After the initial setup, you can run a Camel integration on the cluster by creating an example `Integration`, e.g.:
```
apiVersion: camel.apache.org/v1
kind: Integration
metadata:
  name: example
spec:
  sources:
  - name: Example.java
    content: |
      import org.apache.camel.builder.RouteBuilder;

      public class Example extends RouteBuilder {
          @Override
          public void configure() throws Exception {
              from("timer:tick")
                  .setBody(constant("Hello World!"))
              .to("log:info?skipBodyLineSeparator=false");
          }
      }
```
