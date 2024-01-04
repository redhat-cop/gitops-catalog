# web-terminal

Start a Web Terminal in your browser with common CLI tools for interacting with
the cluster.

**Note:** The Web Terminal Operator integrates with the OpenShift Console in
OpenShift 4.5.3 and higher to simplify Web Terminal instance creation and
automate OpenShift login. In earlier versions of OpenShift, the operator can
be installed but Web Terminals will have to be created and accessed manually.

## Description
The Web Terminal Operator leverages the
[DevWorkspace Operator](https://github.com/devfile/devworkspace-operator)
to provision enviroments which support common cloud CLI tools. When this
operator is installed, the DevWorkspace Operator will be installed as a
dependency.

## How to Install
Press the **Install** button, choose the upgrade strategy, and wait for the
**Installed** Operator status.

When the operator is installed, you will see a terminal button appear on the
top right of the console after refreshing the OpenShift console window.

## How to Uninstall
The Web Terminal Operator requires manual steps to fully uninstall the operator.
As the Web Terminal Operator is designed as a way to access the OpenShift
cluster, Web Terminal instances store user credentials. To avoid exposing these
credentials to unwanted parties, the operator deploys webhooks and finalizers
that aren't removed when the operator is uninstalled. See the
[uninstall guide](https://docs.openshift.com/container-platform/latest/web_console/odc-about-web-terminal.html) 
for more details.

## Known Issues
1. [Occasionally you will need to press enter to get a prompt inside of the web-terminal](https://issues.redhat.com/browse/WTO-43)
2. [DevWorkspace is created but not opened after previous devworkspace is removed](https://issues.redhat.com/browse/WTO-44)
