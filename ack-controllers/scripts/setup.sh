#!/bin/bash
# shellcheck disable=SC2155

# kludges
# TODO: ArgoCD Hooks

# get aws creds
get_aws_key(){
  # get aws creds
  export AWS_ACCESS_KEY_ID=$(oc -n kube-system extract secret/aws-creds --keys=aws_access_key_id --to=-)
  export AWS_SECRET_ACCESS_KEY=$(oc -n kube-system extract secret/aws-creds --keys=aws_secret_access_key --to=-)
  export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-west-2}

  echo "AWS_DEFAULT_REGION: ${AWS_DEFAULT_REGION}"
  sleep 4
}

# create secrets for ack controllers
setup_ack_system(){
  NAMESPACE=ack-system

  # manually create ack-system
  setup_namespace "${NAMESPACE}"

  for type in ec2 ecr iam s3 sagemaker
  do
    # oc apply -k ../../ack-${type}-controller/operator/overlays/alpha

    # create ack operator secrets with main creds
    < ../../ack-${type}-controller/overlays/alpha/user-secrets-secret.yaml \
      sed "s@UPDATE_AWS_ACCESS_KEY_ID@${AWS_ACCESS_KEY_ID}@; s@UPDATE_AWS_SECRET_ACCESS_KEY@${AWS_SECRET_ACCESS_KEY}@" | \
      oc -n "${NAMESPACE}" apply -f -
  done
}
