#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OCP_VERSIONS="${OCP_VERSIONS:-v4.18 v4.19 v4.20 v4.21 v4.22}"
CATALOG_IMAGE_BASE="${CATALOG_IMAGE_BASE:-registry.redhat.io/redhat/redhat-operator-index}"
MODE="${1:-report}" # report | generate
CATALOG_CACHE_DIR="${CATALOG_CACHE_DIR:-}"
HAS_CHANGES=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [report|generate]

Compares OLM channels available across multiple Red Hat operator catalog index
versions against existing overlay directories in this repository.

Channels present in any supported version but missing from the repo are reported
as missing. Existing overlays not present in any supported version are reported
as stale and removed in 'generate' mode.

Environment variables:
  OCP_VERSIONS       Space-separated list of OCP versions (default: v4.18 v4.19 v4.20 v4.21 v4.22)
  CATALOG_IMAGE_BASE Base image path (default: registry.redhat.io/redhat/redhat-operator-index)
  CATALOG_CACHE_DIR  Directory containing pre-rendered catalog JSON files named
                     <version>.json (skip opm render)

Requires: opm, yq, jq
EOF
}

check_prereqs() {
  local missing=()
  for cmd in jq yq; do
    command -v "$cmd" &>/dev/null || missing+=("$cmd")
  done
  if [[ -z "${CATALOG_CACHE_DIR:-}" ]]; then
    command -v opm &>/dev/null || missing+=("opm")
  fi
  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "ERROR: missing required tools: ${missing[*]}" >&2
    exit 1
  fi
}

extract_channel_data_for_version() {
  local version="$1"
  local cache_file="${CATALOG_CACHE_DIR:+${CATALOG_CACHE_DIR}/${version}.json}"

  if [[ -n "${cache_file}" && -f "${cache_file}" ]]; then
    echo "  Using cached data: ${cache_file}" >&2
    cat "${cache_file}"
  else
    local image="${CATALOG_IMAGE_BASE}:${version}"
    echo "  Rendering ${image}..." >&2
    opm render "${image}" |
      jq -c 'select(.schema == "olm.channel") | {package, name}'
  fi
}

extract_all_channel_data() {
  local combined=""
  for version in ${OCP_VERSIONS}; do
    echo "Processing catalog index ${version}..." >&2
    local version_data
    version_data="$(extract_channel_data_for_version "$version")"
    if [[ -n "$combined" ]]; then
      combined="${combined}"$'\n'"${version_data}"
    else
      combined="${version_data}"
    fi
  done
  echo "$combined" | sort -u
}

get_catalog_channels() {
  local pkg_name="$1"
  echo "${CHANNEL_DATA}" | jq -r --arg pkg "$pkg_name" \
    'select(.package == $pkg) | .name' | sort -u
}

find_subscription_dirs() {
  find "${REPO_ROOT}" -maxdepth 4 -path '*/operator/base/subscription.yaml' -type f 2>/dev/null

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
  local sub_file="$1"
  local pkg_name="$2"
  local channel="$3"

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

  echo "    CREATED: ${channel_dir#"${REPO_ROOT}/"}"
}

remove_overlay() {
  local sub_file="$1"
  local channel="$2"

  local overlay_dir
  overlay_dir="$(get_overlay_dir "$sub_file")"
  local channel_dir="${overlay_dir}/${channel}"

  if [[ -d "${channel_dir}" ]]; then
    rm -rf "${channel_dir}"
    echo "    REMOVED: ${channel_dir#"${REPO_ROOT}/"}"
  fi
}

# Names that are overlays in the repo but not real OLM channels
SPECIAL_OVERLAYS="latest default"

is_special_overlay() {
  local name="$1"
  for special in ${SPECIAL_OVERLAYS}; do
    [[ "$name" == "$special" ]] && return 0
  done
  return 1
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

  local catalog_channels
  catalog_channels="$(get_catalog_channels "$pkg_name")"

  if [[ -z "$catalog_channels" ]]; then
    return
  fi

  local overlay_dir existing_overlays
  overlay_dir="$(get_overlay_dir "$sub_file")"
  existing_overlays="$(get_existing_overlays "$overlay_dir")"

  # Filter special overlay names from both comparisons
  local filtered_existing=""
  while IFS= read -r overlay; do
    [[ -z "$overlay" ]] && continue
    is_special_overlay "$overlay" && continue
    filtered_existing="${filtered_existing:+${filtered_existing}$'\n'}${overlay}"
  done <<<"$existing_overlays"

  local missing_channels stale_channels
  missing_channels="$(comm -23 <(echo "$catalog_channels") <(echo "$filtered_existing") 2>/dev/null || true)"
  stale_channels="$(comm -13 <(echo "$catalog_channels") <(echo "$filtered_existing") 2>/dev/null || true)"

  # Nothing to report
  if [[ -z "$missing_channels" && -z "$stale_channels" ]]; then
    return
  fi

  HAS_CHANGES=true
  echo "${operator_name} (package: ${pkg_name})"
  echo "  catalog channels:  $(echo "$catalog_channels" | tr '\n' ' ')"
  echo "  existing overlays: $(echo "$existing_overlays" | tr '\n' ' ')"

  if [[ -n "$missing_channels" ]]; then
    echo "  missing:           $(echo "$missing_channels" | tr '\n' ' ')"
    if [[ "$MODE" == "generate" ]]; then
      while IFS= read -r channel; do
        [[ -z "$channel" ]] && continue
        create_overlay "$sub_file" "$pkg_name" "$channel"
      done <<<"$missing_channels"
    fi
  fi

  if [[ -n "$stale_channels" ]]; then
    echo "  stale:             $(echo "$stale_channels" | tr '\n' ' ')"
    if [[ "$MODE" == "generate" ]]; then
      while IFS= read -r channel; do
        [[ -z "$channel" ]] && continue
        remove_overlay "$sub_file" "$channel"
      done <<<"$stale_channels"
    fi
  fi

  echo ""
}

main() {
  if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
  fi

  check_prereqs

  echo "Supported OCP versions: ${OCP_VERSIONS}"
  echo "Mode: ${MODE}"
  echo ""

  echo "Extracting channel data from catalog indices..."
  CHANNEL_DATA="$(extract_all_channel_data)"
  echo "Done. Checking operators..."
  echo ""

  while IFS= read -r sub_file; do
    [[ -z "$sub_file" ]] && continue
    process_operator "$sub_file"
  done < <(find_subscription_dirs | sort -u)

  if [[ "$HAS_CHANGES" == "false" ]]; then
    echo "All operators are up to date — no missing or stale channel overlays found."
  fi
}

main "$@"
