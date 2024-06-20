#!/bin/bash
# set -x

# shellcheck disable=SC2034

RED='\033[1;31m'
BLUE='\033[1;36m'
PURPLE='\033[1;35m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

check_shell(){
  [ -n "$BASH_VERSION" ] && return
  echo -e "${ORANGE}WARNING: These scripts are ONLY tested in a bash shell${NC}"
  sleep "${SLEEP_SECONDS:-8}"
}

check_shell


usage(){
echo "

This script is ALPHA!

There is probably a better way to do this, but it should help create
the basic file structure needed for an operator.

functions:
  pkg_manifests_get_all
  pkg_manifests_get_all_details
  pkg_manifests_save_all_details

  # ex: rhods-operator
  pkg_manifest_get_info rhods-operator
  pkg_manifest_get_channels rhods-operator
  pkg_manifest_get_description rhods-operator

  create_operator
  create_all_operators
"
}

is_sourced(){
  if [ -n "$ZSH_VERSION" ]; then
      case $ZSH_EVAL_CONTEXT in *:file:*) return 0;; esac
  else  # Add additional POSIX-compatible shell names here, if needed.
      case ${0##*/} in dash|-dash|bash|-bash|ksh|-ksh|sh|-sh) return 0;; esac
  fi
  return 1  # NOT sourced.
}

ocp_check_login(){
  oc whoami || return 1
  oc cluster-info | head -n1
  echo
}

ocp_check_info(){
  ocp_check_login || return 1

  echo "NAMESPACE: $(oc project -q)"
  sleep "${SLEEP_SECONDS:-8}"
}

# pkg.sh
# setup manifest info
MANIFEST_INFO="NAME:.status.packageName"
MANIFEST_INFO="${MANIFEST_INFO},NAMESPACE:.status.channels[0].currentCSVDesc.annotations.operatorframework\.io/suggested-namespace"
MANIFEST_INFO="${MANIFEST_INFO},CATALOG_SOURCE:.status.catalogSource"
MANIFEST_INFO="${MANIFEST_INFO},SOURCE_NAMESPACE:.status.catalogSourceNamespace"
MANIFEST_INFO="${MANIFEST_INFO},DEFAULT_CHANNEL:.status.defaultChannel"
MANIFEST_INFO="${MANIFEST_INFO},CHANNELS:.status.channels[*].name"
MANIFEST_INFO="${MANIFEST_INFO},"'NS_OWN:.status.channels[0].currentCSVDesc.installModes[?(@.type=="OwnNamespace")].supported'
MANIFEST_INFO="${MANIFEST_INFO},"'NS_SINGLE:.status.channels[0].currentCSVDesc.installModes[?(@.type=="SingleNamespace")].supported'
MANIFEST_INFO="${MANIFEST_INFO},"'NS_MULTI:.status.channels[0].currentCSVDesc.installModes[?(@.type=="MultiNamespace")].supported'
MANIFEST_INFO="${MANIFEST_INFO},"'NS_ALL:.status.channels[0].currentCSVDesc.installModes[?(@.type=="AllNamespaces")].supported'
MANIFEST_INFO="${MANIFEST_INFO},DISPLAY_NAME:.status.channels[0].currentCSVDesc.displayName"

BASIC_INFO="NAME:.status.packageName"
BASIC_INFO="${BASIC_INFO},DISPLAY_NAME:.status.channels[0].currentCSVDesc.displayName"
BASIC_INFO="${BASIC_INFO},DEFAULT_CHANNEL:.status.defaultChannel"
BASIC_INFO="${BASIC_INFO},CATALOG_SOURCE:.status.catalogSource"

pkg_manifests_get_all(){
  oc get packagemanifest \
    -o custom-columns="${BASIC_INFO}" \
    --sort-by='.status.catalogSource'
}

pkg_manifests_get_all_by_group(){
  PKG_GROUP=${1:-Red Hat Operators}
  pkg_manifests_get_all | grep "${PKG_GROUP}"
}

pkg_manifests_get_all_names_only(){
  pkg_manifests_get_all | grep -v NAME | awk '{print $1}'
}

pkg_manifests_get_all_details(){
  oc get packagemanifest \
    --sort-by='.status.packageName' \
    -o custom-columns="${MANIFEST_INFO}"
}

pkg_manifest_get_info(){
  [ "${1}x" == "x" ] && return
  NAME="${1}"
  
  oc get packagemanifest \
    "${NAME}" \
    -o=custom-columns="${MANIFEST_INFO}"
}

pkg_manifest_get_channels(){
  [ "${1}x" == "x" ] && return
  NAME="${1}"
  
  echo "NAME: ${NAME}"
  oc get packagemanifest \
    "${NAME}" \
    -o=jsonpath='{range .status.channels[*]}{.name}{"\n"}{end}' | sort
}

pkg_manifest_get_description(){
  [ "${1}x" == "x" ] && return
  NAME="${1}"

  echo -e "# ${NAME}\n"
  oc get packagemanifest \
    "${NAME}" \
    -o=jsonpath="{.status.channels[0].currentCSVDesc.description}"
}

pkg_manifests_save_all_details(){
  echo -e "# created: $(date -u)\n# script: pkg_manifests_save_all_details" > operator_info.txt
  pkg_manifests_get_all_details >> operator_info.txt
}

create_operator_base(){
  [ "${1}x" == "x" ] && return
  NAME="${1}"
  NAMESPACE="${2}"
  DISPLAY_NAME="${3}"
  CATALOG_SOURCE="${4}"
  SOURCE_NAMESPACE="${5}"
  NS_OWN="${6}"

  echo "create_operator_base:" "${@}"

  if [ "${NS_OWN}" == "false" ]  && [ "${NAMESPACE}" == "<none>" ]; then
    BASE_DIR="${NAME}"
    create_operator_base_files_wo_ns
  elif [ "${NS_OWN}" == "true" ] && [ "${NAMESPACE}" == "<none>" ]; then
    BASE_DIR="${NAME}"
    NAMESPACE="${NAME}"
    create_operator_base_files_w_ns
  elif [ ! "${NS_OWN}" == "<none>" ] && [ ! "${NAMESPACE}" == "<none>" ]; then
    BASE_DIR="${NAME}"
    create_operator_base_files_w_ns
  else
    BASE_DIR="${NAME}"
    create_operator_base_files_wo_ns
  fi

  pkg_manifest_get_description "${NAME}" > "${BASE_DIR}/INFO.md"

}

create_operator_dir(){
  [ "${1}x" == "x" ] && return
  BASE_DIR="${1}"
  
  echo "${BASE_DIR}"

  mkdir -p "${BASE_DIR}"/operator/{base,overlays}
}

create_operator_base_files_wo_ns(){
  [ "${NAMESPACE}" == "<none>" ] && NAMESPACE=openshift-operators
  echo "create operator w/o ns"

  create_operator_dir "${BASE_DIR}"
  BASE_PATH="${BASE_DIR}/operator/base"

echo -n "apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
" > "${BASE_PATH}/kustomization.yaml"

if [ "${NAMESPACE}" == "ack-system" ]; then
  echo -n "  - ../../../${NAMESPACE}/base
" >> "${BASE_PATH}/kustomization.yaml"
# else
#   echo -n "
# namespace: ${NAMESPACE}
# " >> "${BASE_PATH}/kustomization.yaml"
fi

echo -n "  - subscription.yaml
" >> "${BASE_PATH}/kustomization.yaml"


cat <<YAML > "${BASE_PATH}/subscription.yaml"
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ${NAME}
  namespace: ${NAMESPACE}
spec:
  channel: patch-me-see-overlays-dir
  installPlanApproval: Automatic
  name: ${NAME}
  source: ${CATALOG_SOURCE}
  sourceNamespace: ${SOURCE_NAMESPACE}
YAML

}

create_operator_base_files_w_ns(){
    echo "create operator w/ ns"

  create_operator_dir "${BASE_DIR}"
  BASE_PATH="${BASE_DIR}/operator/base"

cat <<YAML > "${BASE_PATH}/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - namespace.yaml
  - operator-group.yaml
  - subscription.yaml
YAML

cat <<YAML > "${BASE_PATH}/subscription.yaml"
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ${NAME}
  namespace: ${NAMESPACE}
spec:
  channel: patch-me-see-overlays-dir
  installPlanApproval: Automatic
  name: ${NAME}
  source: ${CATALOG_SOURCE}
  sourceNamespace: ${SOURCE_NAMESPACE}
YAML

cat <<YAML > "${BASE_PATH}/namespace.yaml"
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    openshift.io/display-name: "${DISPLAY_NAME}"
  labels:
    openshift.io/cluster-monitoring: 'true'
  name: ${NAMESPACE}
YAML

cat <<YAML > "${BASE_PATH}/operator-group.yaml"
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: ${NAME}
  namespace: ${NAMESPACE}
YAML

if [ "${NS_SINGLE}" == "true" ] && [ "${NS_ALL}" != "true" ] || [ "${NS_MULTI}" != "false" ]; then
echo -n "spec:
  targetNamespaces:
    - ${NAMESPACE}
" >> "${BASE_PATH}/operator-group.yaml"

fi
}

create_operator_overlay_files(){
[ "${1}x" == "x" ] && return
CHANNEL="${1}"
BASE_PATH="${BASE_DIR}/operator/overlays/${CHANNEL}"

mkdir -p "${BASE_PATH}"

cat <<YAML > "${BASE_PATH}/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

patches:
  - target:
      kind: Subscription
      name: ${NAME}
    path: patch-channel.yaml
YAML

cat <<YAML > "${BASE_PATH}/patch-channel.yaml"
- op: replace
  path: /spec/channel
  value: ${channel}
YAML

}

create_operator_overlays(){
  [ "${1}x" == "x" ] && return
  NAME="${1}"
  BASE_PATH="${BASE_DIR}/operator/overlays"

  for channel in $(pkg_manifest_get_channels "${NAME}" | grep -v NAME)
  do
    echo "overlay: ${channel}"
    create_operator_overlay_files "${channel}"
  done

}

create_operator_readme(){

GIT_REPO=https://github.com/redhat-cop/gitops-catalog

cat <<HTML > "${BASE_DIR}/README.md"
# ${DISPLAY_NAME}

Install ${DISPLAY_NAME}.

Do not use the \`base\` directory directly, as you will need to patch the \`channel\` based on the version of OpenShift you are using, or the version of the operator you want to use.

The current *overlays* available are for the following channels:

$(for channel in $(pkg_manifest_get_channels "${NAME}" | grep -v NAME)
  do
    echo "* [${channel}](operator/overlays/${channel})"
  done
)

## Usage

If you have cloned the \`gitops-catalog\` repository, you can install ${DISPLAY_NAME} based on the overlay of your choice by running from the root (\`gitops-catalog\`) directory.

\`\`\`
oc apply -k ${BASE_DIR}/operator/overlays/<channel>
\`\`\`

Or, without cloning:

\`\`\`
oc apply -k ${GIT_REPO}/${BASE_DIR}/operator/overlays/<channel>
\`\`\`

As part of a different overlay in your own GitOps repo:

\`\`\`
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ${GIT_REPO}/${BASE_DIR}/operator/overlays/<channel>?ref=main
\`\`\`
HTML

}

create_operator(){
  [ "${1}x" == "x" ] && return
  NAME="${1}"

  read -r NAME NAMESPACE CATALOG_SOURCE SOURCE_NAMESPACE DEFAULT_CHANNEL CHANNELS NS_OWN NS_SINGLE NS_MULTI NS_ALL DISPLAY_NAME <<<"$(pkg_manifest_get_info "${NAME}" | grep -v NAME)"

  if [ -z "$DEBUG" ]; then
    echo "NAME: ${NAME}"
    echo "NAMESPACE: ${NAMESPACE}"
    echo "CATALOG_SOURCE: ${CATALOG_SOURCE}"
    echo "SOURCE_NAMESPACE: ${SOURCE_NAMESPACE}"
    echo "DEFAULT_CHANNEL: ${DEFAULT_CHANNEL}"
    echo "CHANNELS: ${CHANNELS}"
    echo "NS_OWN: ${NS_OWN}"
    echo "NS_SINGLE: ${NS_SINGLE}"
    echo "NS_MULTI: ${NS_MULTI}"
    echo "NS_ALL: ${NS_ALL}"
    echo "DISPLAY_NAME: ${DISPLAY_NAME}"
  fi

  create_operator_base "${NAME}" "${NAMESPACE}" "${DISPLAY_NAME}" "${CATALOG_SOURCE}" "${SOURCE_NAMESPACE}" "${NS_OWN}"
  create_operator_overlays "${NAME}"
  create_operator_readme

}

create_all_operators(){
  for package in nfd opendatahub-operator serverless-operator openshift-gitops-operator rhods-operator
  # for package in $(pkg_manifests_get_all_names_only)
  do
    create_operator "${package}"
  done
}

# shellcheck disable=SC2015
is_sourced && usage || pkg_manifests_get_all
