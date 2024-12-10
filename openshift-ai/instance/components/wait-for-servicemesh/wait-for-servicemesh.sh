#!/usr/bin/env bash
set -e

TIMEOUT_SECONDS=60

wait_for_service_mesh(){
  echo "Checking status of all service_mesh and serverless and serverless pre-reqs"
  SERVICEMESH_RESOURCES=(
    crd/knativeservings.operator.knative.dev:condition=established
    crd/servicemeshcontrolplanes.maistra.io:condition=established \
  )

  for field in "${SERVICEMESH_RESOURCES[@]}"
  do
    RESOURCE=$(echo "$field" | cut -d ":" -f 1)
    CONDITION=$(echo "$field" | cut -d ":" -f 2)

    echo "Waiting for ${RESOURCE} state to be ${CONDITION}..."
    oc wait --for="${CONDITION}" "${RESOURCE}" --timeout="${TIMEOUT_SECONDS}s"

  done
}

wait_for_service_mesh
