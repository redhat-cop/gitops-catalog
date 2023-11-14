# serverless-operator

The Red Hat OpenShift Serverless operator provides a collection of APIs that
enables containers, microservices and functions to run "serverless".
Serverless applications can scale up and down (to zero) on demand and be triggered by a
number of event sources. OpenShift Serverless integrates with a number of
platform services, such as Monitoring and it is based on the open
source project Knative.

# Prerequisites
Knative Serving (and Knative Eventing respectively) can only be installed into the
`knative-serving` (`knative-eventing`) namespace. These namespaces will be
automatically created when installing the operator.

The components provided with the OpenShift Serverless operator require minimum cluster sizes on
OpenShift Container Platform. For more information, see the documentation on [Getting started
with OpenShift Serverless](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.13/html/serverless/installing-serverless#install-serverless-operator).

# Supported Features
- **Easy to get started:** Provides a simplified developer experience to deploy
  and run cloud native applications on Kubernetes, providing powerful
  abstractions.
- **Immutable Revisions:** Deploy new features performing canary, A/B or
  blue-green testing with gradual traffic rollout following best practices.
- **Use any programming language or runtime of choice:** From Java, Python, Go
  and JavaScript to Quarkus, SpringBoot or Node.js.
- **Automatic scaling:** Removes the requirement to configure numbers of replicas
  or idling behavior. Applications automatically scale to zero when not in use,
  or scale up to meet demand, with built in reliability and fault tolerance.
- **Event Driven Applications:** You can build loosely coupled, distributed applications
  that can be connected to a variety of either built in or third party event sources,
  powered by operators.
- **Ready for the hybrid cloud:** Provides true, portable serverless functionality,
  that can run anywhere OpenShift Container Platform runs. You can leverage data
  locality and SaaS as you need it.

# Components & APIs
This operator provides the following components:

## Knative Serving
Knative Serving builds on Kubernetes to support deploying and serving of applications and functions as serverless containers.
Serving simplifies the application deployment, dynamically scales based on in incoming traffic and supports custom rollout strategies with traffic splitting.
Other features include:
- Simplified deployment of serverless containers
- Traffic-based auto-scaling, including scale-to-zero
- Routing and network programming
- Point-in-time application snapshots and their configurations

## Knative Eventing
Knative Eventing provides a platform that offers composable primitives to enable late-binding event sources and
event consumers.
Knative Eventing supports the following architectural cloud-native concepts:

- Services are loosely coupled during development and deployed independently to production
- A producer can generate events before a consumer is listening, and a consumer can express an interest in an event or class of events that are not yet being produced.
- Services can be connected to create new applications without modifying producer or consumer, and with the ability to select a specific subset of events from a particular producer.

## Knative Functions
Knative Functions allows developers to write functions that let them focus on business logic.
These functions are deployed as Knative Services and take advantage of Knative Serving and Eventing.
Knative Functions bring greater efficiency, more scalability and faster development to facilitate rapid go-to-market.

Other features include:
- Build strategies including Source-to-Image (S2I) and Buildpacks
- Multiple runtimes, including Node.js, Quarkus and Go
- Local developer experience through the kn CLI
- Project templates
- Support for receiving CloudEvents and plain HTTP requests

## Knative CLI `kn`
The Knative client `kn` allows you to create Knative resources from the command line or from within
Shell scripts.
With its extensive help pages and autocompletion support, it frees you from memorizing the detailed structure of the Knative resource schemas.

`kn` offers you:
- Full support for managing all features of Knative Serving: Services, Revisions and Routes
- Support for managing Knative Eventing entities: Sources, Brokers, Triggers, Channels and Subscriptions
- A kubectl-like plugin architecture to extend the built-in functionality
- Easy integration of Knative into Tekton pipelines by using `kn` in a Tekton task
- Create, build and deploy Knative Functions for multiple runtimes, including Node.js, Quarkus, and Go

# Further Information
For documentation on OpenShift Serverless, see:
- [Installation
Guide](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.13/html/serverless/installing-serverless)
- [Develop Serverless Applications](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.13/html/serverless/serving#serverless-applications)