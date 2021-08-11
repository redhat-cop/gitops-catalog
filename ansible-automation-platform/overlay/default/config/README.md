__Using Ansible Tower OpenShit Install__

Find [here](https://docs.ansible.com/ansible-tower/3.4.3/html/administration/openshift_configuration.html) how to use it 

__Adjust the deployment__

Make sure to replace to following variables with your cluster / user information in the `inventory` file.

~~~
$CLUSTER_NAME.$DOMAIN_NAME
$OCP_USER
$OCP_PASSWORD
~~~

Feel free also to edit other values; make sure to follow the documentation linked above.

__Generate Ansible Tower inventory secret__

`kustomize build ./ > ansible-tower-inventory.yaml`

__Seal the Ansible Tower secret__

`kubeseal --cert ~/.bitnami/tls.crt --format yaml < ansible-tower-inventory.yaml > ../06-sealed-ansible-tower-inventory.yaml`