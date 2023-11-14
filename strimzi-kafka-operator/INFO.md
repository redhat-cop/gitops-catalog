# strimzi-kafka-operator

Strimzi provides a way to run an [Apache Kafka®](https://kafka.apache.org) cluster on  [Kubernetes](https://kubernetes.io/) or [OpenShift](https://www.openshift.com/) in various deployment configurations. See our [website](https://strimzi.io) for more details about the project.

**Strimzi 0.34 supports only Kubernetes 1.19 and newer! Kubernetes versions 1.16, 1.17 and 1.18 are not supported anymore since Strimzi 0.32.**
### Upgrades
**!!! IMPORTANT !!!** **Direct upgrade from Strimzi 0.22 or earlier is not supported anymore!**  You have to upgrade first to one of the previous versions of Strimzi.  You will also need to convert the CRD resources.  For more details, see the [documentation](https://strimzi.io/docs/operators/0.34.0/deploying.html#assembly-upgrade-str).
### New in 0.34
* Add support for Apache Kafka 3.4.0 (fixes CVE-2023-25194) and remove support for Apache Kafka 3.2.x
* Stable Pod identities for Kafka Connect and MirrorMaker 2 (disabled by default)
* Use JDK HTTP client in the Kubernetes client instead of the OkHttp client
* Add truststore configuration for HTTPS connections to Open Policy Agent server
* Update Strimzi HTTP Bridge to 0.25.0 and strimzi Oauth to 0.12.0
### Supported Features
* **Manages the Kafka Cluster** - Deploys and manages all of the components of this complex application, including dependencies like Apache ZooKeeper® that are traditionally hard to administer.
* **Includes Kafka Connect** - Allows for configuration of common data sources and sinks to move data into and out of the Kafka cluster.
* **Topic Management** - Creates and manages Kafka Topics within the cluster.
* **User Management** - Creates and manages Kafka Users within the cluster.
* **Connector Management** - Creates and manages Kafka Connect connectors.
* **Includes Kafka Mirror Maker 1 and 2** - Allows for mirroring data between different Apache Kafka® clusters.
* **Includes HTTP Kafka Bridge** - Allows clients to send and receive messages through an Apache Kafka® cluster via HTTP protocol.
* **Cluster Rebalancing** - Uses built-in Cruise Control for redistributing partition replicas according to specified goals in order to achieve the best cluster performance.
* **Monitoring** - Built-in support for monitoring using Prometheus and provided Grafana dashboards
### Upgrading your Clusters
The Strimzi Operator understands how to run and upgrade between a set of Kafka versions. When specifying a new version in your config, check to make sure you aren't using any features that may have been removed. See [the upgrade guide](https://strimzi.io/docs/operators/latest/deploying.html#assembly-upgrading-kafka-versions-str) for more information.
### Storage
An efficient data storage infrastructure is essential to the optimal performance of Apache Kafka®. Apache Kafka® deployed via Strimzi requires block storage. The use of file storage (for example, NFS) is not recommended.
The Strimzi Operator supports three types of data storage:
* Ephemeral (Recommended for development only!)
* Persistent
* JBOD (Just a Bunch of Disks, suitable for Kafka only. Not supported in Zookeeper.)
Strimzi also supports advanced operations such as adding or removing disks in Apache Kafka® brokers or resizing the persistent volumes (where supported by the infrastructure).
### Documentation
Documentation to the current _main_ branch as well as all releases can be found on our [website](https://strimzi.io/documentation).
### Getting help
If you encounter any issues while using Strimzi, you can get help using:
* [Strimzi mailing list on CNCF](https://lists.cncf.io/g/cncf-strimzi-users/topics)
* [Strimzi Slack channel on CNCF workspace](https://cloud-native.slack.com/messages/strimzi)
### Contributing
You can contribute by:
* Raising any issues you find using Strimzi
* Fixing issues by opening Pull Requests
* Improving documentation
* Talking about Strimzi
All bugs, tasks or enhancements are tracked as [GitHub issues](https://github.com/strimzi/strimzi-kafka-operator/issues). Issues which  might be a good start for new contributors are marked with ["good-start"](https://github.com/strimzi/strimzi-kafka-operator/labels/good-start) label.
The [Development guide](https://github.com/strimzi/strimzi-kafka-operator/blob/main/development-docs/DEV_GUIDE.md) describes how to build Strimzi and how to  test your changes before submitting a patch or opening a PR.
The [Documentation Contributor Guide](https://strimzi.io/contributing/guide/) describes how to contribute to Strimzi documentation.
If you want to get in touch with us first before contributing, you can use:
* [Strimzi mailing list on CNCF](https://lists.cncf.io/g/cncf-strimzi-users/topics)
* [Strimzi Slack channel on CNCF workspace](https://cloud-native.slack.com/messages/strimzi)
### License
Strimzi is licensed under the [Apache License, Version 2.0](https://github.com/strimzi/strimzi-kafka-operator/blob/main/LICENSE).
