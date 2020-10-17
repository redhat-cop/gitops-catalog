# OpenShift Web Terminal Operator

**Version: 0.1**

## Usage

This is to deploy a [Web Terminal](https://github.com/redhat-developer/web-terminal-operator) into an OpenShift cluster. This operator
enables you to run a web terminal within the OpenShift Console GUI giving easy availability to tools like oc, helm, etc.

Note that this operator can only be used by non cluster-admin users, it is disabled for cluster-admins. The user must also have access to at least one project to initialize the terminal.