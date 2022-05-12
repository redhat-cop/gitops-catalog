[Kyverno](https://kyverno.io) is a yaml driven policy engine for Kubernetes, this installs Kyverno from the 1.6 release yaml.

The installation of Kyverno is patched so it will ignore various OpenShift specific namespaces, it also adjusts some other settings to perform better in OpenShift.

Note some patches cribbed from ACM installation of Kyverno [here](https://github.com/stolostron/policy-collection/blob/main/community/CM-Configuration-Management/policy-kyverno-config-exclude-resources.yaml).