#!/bin/bash
# shellcheck disable=SC2034,SC2044

display_help(){
  echo "./$(basename "$0") [ -d | --directory DIRECTORY ] [ -e | --enforce-all-schemas ] [ -h | --help ] [ -sl | --schema-location ]
Script to validate the manifests generated by Kustomize
Where:
  -d  | --directory DIRECTORY  Base directory containing Kustomize overlays
  -e  | --enforce-all-schemas  Enable enforcement of all schemas
  -h  | --help                 Display this help text
  -sl | --schema-location      Location containing schemas"
}

which kustomize && KUSTOMIZE_CMD="kustomize build" || echo "Kustomize not in path; using 'oc kustomize' instead"
which helm && GOT_HELM="--enable-helm" || echo "Helm not in path; skipping kustomizations that use helm"

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
KUSTOMIZE_CMD="${KUSTOMIZE_CMD:-oc kustomize}"
IGNORE_MISSING_SCHEMAS="--ignore-missing-schemas"
SCHEMA_LOCATION="./openshift-json-schema"
KUSTOMIZE_DIRS="."

init(){
  for i in "${@}"
  do
    case $i in
      -d | --directory )
        shift
        KUSTOMIZE_DIRS="${1}"
        shift
        ;;
      -e | --enforce-all-schemas )
        IGNORE_MISSING_SCHEMAS=""
        shift
        ;;
      -sl | --schema-location )
        shift
        SCHEMA_LOCATION="${1}"
        shift
        ;;
      -h | --help )
        display_help
        exit 0
        ;;
      -*) echo >&2 "Invalid option: " "${@}"
        exit 1
        ;;
    esac
  done
}

kustomization_auto_fix(){
  BUILD_PATH=${1}

  [ "${KUSTOMIZE_CMD}" == "kustomize build" ] || return
  FIX_CMD="${FIX_CMD:-kustomize edit fix}"

  pushd "${BUILD_PATH}" || return
  ${FIX_CMD}
  popd || return
}

kustomization_build(){
  BUILD=${1}

  local KUSTOMIZE_BUILD_OUTPUT
  if [ -n "${GOT_HELM}" ]; then
    KUSTOMIZE_BUILD_OUTPUT=$(${KUSTOMIZE_CMD} "${BUILD}" "${GOT_HELM}")
  else
    if grep -qe '^helmCharts:$' "${BUILD}/kustomization.yaml" ; then
      echo "[SKIP]"
      return 0
    fi

    # Don't include "${GOT_HELM}" otherwise kustomize thinks that "" (empty string) is another input directory and
    # kustomize immediately exits with message: "Error: specify one path to kustomization.yaml"
    KUSTOMIZE_BUILD_OUTPUT=$(${KUSTOMIZE_CMD} "${BUILD}")
  fi
  # echo "$KUSTOMIZE_BUILD_OUTPUT" | kubeval ${IGNORE_MISSING_SCHEMAS} --schema-location="file://${SCHEMA_LOCATION}" --force-color

  cmd_response=$?

  if [ $cmd_response -ne 0 ]; then
    # It is valid for components to reference resources not directly included into the component definition, so don't
    # error out on components that fail a `kustomize build`
    if grep -qe '^kind: Component$' "${BUILD}/kustomization.yaml"; then
      echo "[SKIP]"
      return 0
    fi

    echo "[ERROR]"
    exit 1
  fi

  echo "[OK]"
}

kustomization_process(){
  echo "Validating..."

  for LINT in $(find "${KUSTOMIZE_DIRS}" -name "kustomization.yaml" -exec dirname {} \;)
  do
    echo "${LINT}"
    kustomization_build "${LINT}"
    # kustomization_auto_fix "${LINT}"
  done

  echo "Kustomize check passed :)"
}

init "${@}"
kustomization_process
