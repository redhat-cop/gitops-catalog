# Install Plan Approver

In OCP 4 when you set an operator for manual upgrades you need to manually approve the initial deployment which is challenging in a gitops world. The installplan-approver-job created by Andrew Pitt can be used to approve all pending installplans in the namespace in which it is deployed.