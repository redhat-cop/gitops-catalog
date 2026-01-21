# Operator GitOps Deployment Template

## How to use this template

This template can be used to setup an automated Operator deployment and upgrade capability that leverages GitOps using ArgoCD. This template is built using Kustomize to allow for customization of the deployment as well as specific configurations for each environment category to be deployed to. This includes specific configuration for Staging, Development, and Production.

To use this template:

Clone to new repo
1) Create a new repository to host the new operator within Git
2) Copy the contents from this repo into your new repo as the starting point or on repo creation just to copy this existing repo
3) All following code changes should be made to your copy of this content in the new repo and not to the original template content

Gather Information
1) Identify the Operator you wish to configure deployment using this GitOps Template
2) Identify the Channel you wish the operator to use  
	a) this can be done by installing the operator and reviewing the channel choice in the subscription object  
3) Identify the install version, and desired update version if different from install version  
	a) this can be done by installing the operator in the test environment and viewing the ClusterSubscriptionVersion (CSV) file associated with the deployment  
4) Identify the target namespace for the operator. The template is built around using operatorname-operator as its basis so this is the easiest format to use. i.e. amqstreams-operator  
5) Identify any customizations you need to apply to the operator deployment. This are not usually required, but sometimes are in special cases. i.e. FIPS configuration for AMQ-Streams  

Update Template
1) Update the filename of all included yaml files to be named appropriately for the desired operator. i.e. operatorname-operator-subscription.yaml -> amqstreams-operator-subscription.yaml 

Here is a rename command that you may be able to use depending on your setup:  
`rename 's/operatorname/rhsso/' *yaml`

2) Find all instances of "operatorname-operator" within the included yaml files and replace with the appropriate name. The following is a list of each instance of this item  
base/kustomization.yaml:  - operatorname-operator-subscription.yaml  
base/kustomization.yaml:  - operatorname-operator-operatorgroup.yaml  
base/kustomization.yaml:  - operatorname-operator-install-approvaljob.yaml  
base/kustomization.yaml:  - operatorname-operator-upgrade-approvaljob.yaml  
base/kustomization.yaml:  - operatorname-operator-rbac.yaml  
base/operatorname-operator-install-approvaljob.yaml:  namespace: operatorname-operator  
base/operatorname-operator-install-approvaljob.yaml:              value: "operatorname-operator"  
base/operatorname-operator-rbac.yaml:  namespace: operatorname-operator  
base/operatorname-operator-rbac.yaml:  namespace: operatorname-operator  
base/operatorname-operator-sa.yaml:  namespace: operatorname-operator  
base/operatorname-operator-subscription.yaml:  namespace: operatorname-operator  
base/operatorname-operator-upgrade-approvaljob.yaml:  namespace: operatorname-operator  
base/operatorname-operator-upgrade-approvaljob.yaml:              value: "operatorname-operator"  
base/operatorname-operator-operatorgroup.yaml:  namespace: operatorname-operator  
base/operatorname-operator-operatorgroup.yaml:    - operatorname-operator  
overlays/Development/kustomization.yaml:namespace: operatorname-operator  
overlays/Production/kustomization.yaml:namespace: operatorname-operator  
overlays/Staging/kustomization.yaml:namespace: operatorname-operator  

Here is a sed command that can help you quickly rename these. Please verify correctness after running the command:  
`find . -type f -name "*.yaml" -exec sed -i 's/operatorname-operator/newname-operator/g' {} +`  
where newname is the name you would be inserting such as amqstreams  

Next replace all instances of the term "operatorname" with the appropriate name for the operator. Here is a list of all of these instances that need replacement:  
operatorname-operator-install-approvaljob.yaml: name: operatorname-versions  
operatorname-operator-subscription.yaml:  name: operatorname  
operatorname-operator-subscription.yaml:  name: operatorname  
operatorname-operator-upgrade-approvaljob.yaml: name: operatorname-versions  
operatorname-operator-operatorgroup.yaml:  name: operatorname-og  

Here is a sed command that can help you quickly rename these. Please verify correctness after running the command:  
`find . -type f -name "*.yaml" -exec sed -i 's/operatorname/newname/g' {} +`  
where newname is the name you would be inserting such as amqstreams  

3) Update the subscription.yaml  
	a) Identify the appropriate name for the subscription from the "Gather Information" stage. It is important to get this correct or the install will not complete successfully. The subscription object spec/name field must match the name part of the version string  
	b) Identify the appropriate channel from the "Gather Information" stage. Often is "stable" which is the default in the template  
	c) Identify the version for the "Gather Information" stage and add it to the startingCSV section replacing "operator-install-version".  

4) Update BOTH approvaljob yaml files  
	a) Ensure the name field was updated correctly by the automatic rename commands  
	b) Next, update the configuration fields list here:
	   `       env:  
            - name: APPROVAL_NAMESPACE  
              value: "operatorname-operator"  
            - name: APPROVAL_SUB  
              value: "subscriptionobjectname"  
          envFrom:  
            - configMapRef:  
                name: operatorname-versions`  
	c) The APPROVAL_NAMESPACES value should be updated by the automatic renaming command  
	d) The APPROVAL_SUB field needs to be manually update with the name of the subscription object. If using the standard conventions this should be operatorname-operator.  
	e) The configmapRef/name field should be updated to match the name identified in the overlay kustomization files in the next field. Usually this just means replacing operatorname with the appropriate name  


5) Update the version files  
	a) In each overlay directory there is a kustomizations.yaml file. Edit that file by ensuring the namespace field and configMapGenerator/name: operatorname-versions were updated properly from the automatic replacement commands   
	b) Open each operator.versions file and add the appropriate version information found in the "Gather Information" section  
	*Note* You do NOT need to change the name of the operator.versions file. This keeps it's same name and only the contents inside change  
	c) If your initial install and upgrade version are the same, just enter the same version information in each field  

6) Add any additional customizations using Kustomize Patches  
	a) Examples of kustomize patches can be found in a txt file in the root of this repository  
	b) These can be added to the kustomize.yaml in each of the overlay sections, or the base kustomize.yaml  
	c) These allow you to edit/change/configure sections of each yaml and handle that differently for each overlay  

7) Update the README here with the templates default content below to match information related to the specifics of the operator you have configured with this template

8) Push code changes to Git and configure your ArgoCD Application to use the newly created and configured content

# Operator GitOps Deployment Capability

## Description

This code base provides a template, that when completed, can be ingested by ArgoCD/Red Hat Git Ops to deploy and manage the configured Operator into an OpenShift cluster using GitOps.

The code is structured using kustomize to template the included yaml and allow customized deployment to multiple environments including Staging, Development, and Production

This code can also be used to manage the version or upgrade of the operator installed and ensure consistency across all clusters in a particular environment category.

## Installation

To utilize this project first ensure you have created a credential robot account for the repository and can provide those credentials in a ArgoCD Credentials object. Next, setup a new "Application" within your ArgoCD Instance that has access to the repository you cloned this template into. Target the appropriate overlay by providing the path. This should match the environment you are deploying the operator too. Use overlay/Staging for Staging overlay/Development for Development and overlay/Production for production.

You can verify what versions will be targeted for initial installation and the final upgraded version by checking the operator.versions file within each of the overlay folders

Once the application is created within ArgoCD use the Sync actions to advance the configuration.

Sync 1 - Installs the Operator Subscription into the target Namespace and generates an InstallPlan to do the actual operator installation  
Sync 2- Approves the initial InstallPlan and allows the cluster to finish the initial installation of the Operator into the target namespace  
Sync 3- Approves any generated InstallPlans for upgrading the Operator to the version that is found the operator.version file and allows that upgrade to complete  
  
Your Operator is now installed, upgraded, and ready for use.  

## Usage

This code is leveraged in a GitOps fashion by ArgoCD so any changes to configuration or capability are done directly within the Git Repository. Here are some potential configuration changes and how to action them:
  
Changing Install Version: in the appropriate overlay (staging, development, production) update the operator.version file to have the new initial version you wish to install. Also, update the subscription objects desiredCSV field to have the new initial version.  

Changing the Upgrade Version: in the appropriate overlay (staging, development, production) update the operator.version file to have the new upgrade version you wish to install. Run the "sync" operation and any install plans available for that version will be approved and the upgrade will roll out.  


## Features

This code works by leveraging 2 OpenShift Jobs to approve InstallPlans for when Operators are set to "Manual" Approval mode. These Jobs leverage a serviceaccount within the cluster to check for install plans that match the versions in the operator.version file and approve them as needed. Once approved OpenShift handles migrating the Operator to the version approved in the InstallPlan  
