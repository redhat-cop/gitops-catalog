#!/bin/bash
# shellcheck disable=SC2034,SC2044

HELM_DIRS="."

which helm || return

helm_lint_path(){
  LINT=${1}
  HELM_LINT_OUTPUT=$(helm lint "${LINT}")

  cmd_response=$?

  if [ $cmd_response -ne 0 ]; then
    echo "[ERROR]"
    exit 1
  fi

  echo "[OK]"
}

helm_process(){
  echo "Validating..."

  for LINT in $(find ${HELM_DIRS} -name "Chart.yaml" -exec dirname {} \;)
  do
    echo "${LINT}"
    helm_lint_path "${LINT}"
  done

  echo "Helm check passed :)"
}

helm_process
