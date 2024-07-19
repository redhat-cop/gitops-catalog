#!/bin/bash
# shellcheck disable=SC2155

# kludges
# TODO: ArgoCD Hooks

setup_namespace(){
  NAMESPACE=${1}

  oc new-project "${NAMESPACE}" 2>/dev/null || \
    oc project "${NAMESPACE}"
}

ocp_aws_cluster(){
  oc -n kube-system get secret/aws-creds -o name > /dev/null 2>&1 || return 1
}

ocp_aws_get_key(){
  # get aws creds
  ocp_aws_cluster || return 1
  
  AWS_ACCESS_KEY_ID=$(oc -n kube-system extract secret/aws-creds --keys=aws_access_key_id --to=-)
  AWS_SECRET_ACCESS_KEY=$(oc -n kube-system extract secret/aws-creds --keys=aws_secret_access_key --to=-)
  AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-east-2}

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_DEFAULT_REGION

  echo "AWS_DEFAULT_REGION: ${AWS_DEFAULT_REGION}"
}

# create secrets for ack controllers
ocp_aws_setup_ack_system(){
  NAMESPACE=ack-system

  ocp_aws_get_key

  setup_namespace "${NAMESPACE}"

  oc apply -k ../"${NAMESPACE}"/aggregate/popular

  for type in ec2 ecr iam lambda route53 s3 sagemaker
  do

    oc apply -k ../ack-${type}-controller/operator/overlays/alpha

    if oc -n "${NAMESPACE}" get secret "${type}-user-secrets" -o name; then
      echo "Found: ${type}-user-secrets - not replacing"
      continue
    fi

    < ../ack-${type}-controller/operator/overlays/alpha/user-secrets-secret.yaml \
      sed "s@UPDATE_AWS_ACCESS_KEY_ID@${AWS_ACCESS_KEY_ID}@; s@UPDATE_AWS_SECRET_ACCESS_KEY@${AWS_SECRET_ACCESS_KEY}@" | \
      oc -n "${NAMESPACE}" apply -f -
  done
}

ocp_aws_setup_ack_system
