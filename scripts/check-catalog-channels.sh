#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OCP_VERSION="${OCP_VERSION:-v4.17}"
CATALOG_IMAGE="${CATALOG_IMAGE:-registry.redhat.io/redhat/redhat-operator-index:${OCP_VERSION}}"
MODE="${1:-report}" # report | generate
CATALOG_CACHE="${CATALOG_CACHE:-}"
HAS_MISSING=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [report|generate]

Compares OLM channels available in the Red Hat operator catalog index against
existing overlay directories in this repository. In 'generate' mode, creates
missing overlay directories.

Environment variables:
  OCP_VERSION      OpenShift version tag (default: v4.17)
  CATALOG_IMAGE    Full catalog index image reference (overrides OCP_VERSION)
  CATALOG_CACHE    Path to pre-rendered catalog JSON (skip opm render)

Requires: opm, yq, jq
EOF
}

check_prereqs() {
  local missing=()
  for cmd in jq yq; do
    command -v "$cmd" &>/dev/null || missing+=("$cmd")
  done
  if [[ -z "${CATALOG_CACHE:-}" ]]; then
    command -v opm &>/dev/null || missing+=("opm")
  fi
  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "ERROR: missing required tools: ${missing[*]}" >&2
    exit 1
  fi
}

extract_channel_data() {
  if [[ -n "${CATALOG_CACHE:-}" && -f "${CATALOG_CACHE}" ]]; then
    echo "Using cached catalog data: ${CATALOG_CACHE}" >&2
    cat "${CATALOG_CACHE}"
  else
    echo "Rendering catalog from ${CATALOG_IMAGE} (this may take a few minutes)..." >&2
    opm render "${CATALOG_IMAGE}" 2>/dev/null |
      jq -c 'select(.schema == "olm.channel") | {package, name}'
  fi
}

get_catalog_channels() {
  local pkg_name="$1"
  echo "${CHANNEL_DATA}" | jq -r --arg pkg "$pkg_name" \
    'select(.package == $pkg) | .name' | sort -u
}

find_subscription_dirs() {
  # New layout: <operator>/operator/base/subscription.yaml
  find "${REPO_ROOT}" -maxdepth 4 -path '*/operator/base/subscription.yaml' -type f 2>/dev/null

  # Old layout: <operator>/base/subscription.yaml (not under operator/)
  find "${REPO_ROOT}" -maxdepth 3 -path '*/base/subscription.yaml' -type f 2>/dev/null |
    while read -r f; do
      [[ "$f" == */operator/base/* ]] && continue
      echo "$f"
    done
}

get_overlay_dir() {
  local sub_file="$1"
  if [[ "$sub_file" == */operator/base/subscription.yaml ]]; then
    echo "$(dirname "$(dirname "$sub_file")")/overlays"
  else
    local base_dir
    base_dir="$(dirname "$(dirname "$sub_file")")"
    echo "${base_dir}/overlays"
  fi
}

get_existing_overlays() {
  local overlay_dir="$1"
  if [[ -d "$overlay_dir" ]]; then
    find "$overlay_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
  fi
}

get_operator_name() {
  local sub_file="$1"
  if [[ "$sub_file" == */operator/base/subscription.yaml ]]; then
    basename "$(dirname "$(dirname "$(dirname "$sub_file")")")"
  else
    basename "$(dirname "$(dirname "$sub_file")")"
  fi
}

create_overlay() {
  local operator_dir="$1"
  local sub_file="$2"
  local pkg_name="$3"
  local channel="$4"

  local overlay_dir
  overlay_dir="$(get_overlay_dir "$sub_file")"
  local channel_dir="${overlay_dir}/${channel}"

  mkdir -p "${channel_dir}"

  cat <<YAML >"${channel_dir}/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

patches:
  - target:
      kind: Subscription
      name: ${pkg_name}
    path: patch-channel.yaml
YAML

  cat <<YAML >"${channel_dir}/patch-channel.yaml"
- op: replace
  path: /spec/channel
  value: ${channel}
YAML

  echo "  CREATED: ${channel_dir#"${REPO_ROOT}/"}"
}

process_operator() {
  local sub_file="$1"
  local operator_name
  operator_name="$(get_operator_name "$sub_file")"

  local pkg_name catalog_source
  pkg_name="$(yq '.spec.name' "$sub_file")"
  catalog_source="$(yq '.spec.source' "$sub_file")"

  if [[ "$catalog_source" != "redhat-operators" ]]; then
    return
  fi

  local catalog_channels existing_overlays
  catalog_channels="$(get_catalog_channels "$pkg_name")"

  if [[ -z "$catalog_channels" ]]; then
    return
  fi

  local overlay_dir
  overlay_dir="$(get_overlay_dir "$sub_file")"
  existing_overlays="$(get_existing_overlays "$overlay_dir")"

  # Find channels in catalog but not in existing overlays
  local missing_channels
  missing_channels="$(comm -23 <(echo "$catalog_channels") <(echo "$existing_overlays"))"

  # Filter out special overlay names that aren't real OLM channels
  missing_channels="$(echo "$missing_channels" | grep -v '^latest$' | grep -v '^default$' || true)"

  if [[ -z "$missing_channels" ]]; then
    return
  fi

  HAS_MISSING=true
  echo "${operator_name} (package: ${pkg_name})"
  echo "  catalog channels:  $(echo "$catalog_channels" | tr '\n' ' ')"
  echo "  existing overlays: $(echo "$existing_overlays" | tr '\n' ' ')"
  echo "  missing:           $(echo "$missing_channels" | tr '\n' ' ')"

  if [[ "$MODE" == "generate" ]]; then
    while IFS= read -r channel; do
      [[ -z "$channel" ]] && continue
      create_overlay "$operator_name" "$sub_file" "$pkg_name" "$channel"
    done <<<"$missing_channels"
  fi

  echo ""
}

main() {
  if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
  fi

  check_prereqs

  echo "Catalog: ${CATALOG_IMAGE}"
  echo "Mode: ${MODE}"
  echo ""

  echo "Extracting channel data from catalog index..."
  CHANNEL_DATA="$(extract_channel_data)"
  echo "Done. Checking operators..."
  echo ""

  while IFS= read -r sub_file; do
    [[ -z "$sub_file" ]] && continue
    process_operator "$sub_file"
  done < <(find_subscription_dirs | sort -u)

  if [[ "$HAS_MISSING" == "false" ]]; then
    echo "All operators are up to date — no missing channel overlays found."
  fi
}

main "$@"
