#!/usr/bin/env bash
#
# Compares OLM (Operator Lifecycle Manager) channel overlays in this repo
# against the channels actually published in Red Hat catalog indices.
#
# Each operator in the repo has a base Subscription plus per-channel overlay
# directories under overlays/. This script detects overlays that are missing
# (channel exists in the catalog but not in the repo) or stale (overlay exists
# but the channel was removed from every supported OCP version's catalog).
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OCP_VERSIONS="${OCP_VERSIONS:-v4.18 v4.19 v4.20 v4.21 v4.22}"
CATALOGS="${CATALOGS:-redhat-operators certified-operators community-operators}"
MODE="${1:-report}" # report | generate | list
CATALOG_CACHE_DIR="${CATALOG_CACHE_DIR:-}"
OPERATOR_FILTER="${OPERATOR_FILTER:-}"
HAS_CHANGES=false
ERRORS=false
IGNORE_MISSING="${IGNORE_MISSING:-false}"
MISSING_CATALOG_MSGS=()
IGNORED_OPERATORS="${IGNORED_OPERATORS:-rhoda-operator}"

usage() {
  cat <<EOF
Usage: $(basename "$0") [report|generate|list]

Compares OLM channels available across Red Hat, Certified, and Community
operator catalog indices against existing overlay directories in this repository.

Channels present in any supported version but missing from the repo are reported
as missing. Existing overlays not present in any supported version are reported
as stale and removed in 'generate' mode. The 'list' mode outputs only the names
of operators that have changes (one per line), for use in CI matrix strategies.

Environment variables:
  OCP_VERSIONS       Space-separated list of OCP versions (default: v4.18 v4.19 v4.20 v4.21 v4.22)
  CATALOGS           Space-separated catalog sources (default: redhat-operators certified-operators community-operators)
  CATALOG_CACHE_DIR  Directory containing pre-rendered catalog JSON files named
                     <catalog>-<version>.json (skip opm render)
  OPERATOR_FILTER    If set, only process the operator with this name
  IGNORE_MISSING     If true, skip operators not found in any catalog instead of erroring (default: false)
  IGNORED_OPERATORS  Space-separated list of operator directory names to skip entirely,
                     e.g. operators that use a custom CatalogSource (default: rhoda-operator)

Requires: opm, yq, jq
EOF
}

check_prereqs() {
  # opm is only required when rendering live from the registry;
  # cached JSON files (CATALOG_CACHE_DIR) bypass the opm dependency.
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

# Derives the registry image path from a catalog name.
# e.g. "redhat-operators" -> "registry.redhat.io/redhat/redhat-operator-index"
#      "certified-operators" -> "registry.redhat.io/redhat/certified-operator-index"
get_catalog_image_base() {
  local catalog="$1"
  local index_name="${catalog%-operators}-operator-index"
  echo "registry.redhat.io/redhat/${index_name}"
}

# Extracts channel metadata from a single catalog+version combination.
# Uses cached JSON if CATALOG_CACHE_DIR is set; otherwise renders the
# catalog image live with `opm render` and filters for olm.channel entries.
# Output: one JSON object per line with {package, name, source}.
extract_channel_data_for_catalog_version() {
  local catalog="$1"
  local version="$2"
  local cache_file="${CATALOG_CACHE_DIR:+${CATALOG_CACHE_DIR}/${catalog}-${version}.json}"

  if [[ -n "${cache_file}" && -f "${cache_file}" ]]; then
    echo "  Using cached data: ${cache_file}" >&2
    cat "${cache_file}"
  else
    local image_base
    image_base="$(get_catalog_image_base "$catalog")"
    local image="${image_base}:${version}"
    echo "  Rendering ${image}..." >&2
    opm render "${image}" |
      jq -c --arg src "$catalog" \
        'select(.schema == "olm.channel") | {package, name, source: $src}'
  fi
}

# Collects channel data across all catalog×version combinations and
# deduplicates. A channel present in multiple OCP versions appears only once
# in the output — we care about the union of channels across all versions.
extract_all_channel_data() {
  local combined=""
  for catalog in ${CATALOGS}; do
    for version in ${OCP_VERSIONS}; do
      echo "Processing ${catalog} ${version}..." >&2
      local version_data
      version_data="$(extract_channel_data_for_catalog_version "$catalog" "$version")"
      if [[ -n "$combined" ]]; then
        combined="${combined}"$'\n'"${version_data}"
      else
        combined="${version_data}"
      fi
    done
  done
  echo "$combined" | sort -u
}

# Filters the pre-loaded CHANNEL_DATA for a specific operator package and
# catalog source, returning the sorted list of channel names.
get_catalog_channels() {
  local pkg_name="$1"
  local source="$2"
  echo "${CHANNEL_DATA}" | jq -r --arg pkg "$pkg_name" --arg src "$source" \
    'select(.package == $pkg and .source == $src) | .name' | sort -u
}

# Locates all subscription.yaml files in the repo.
# Supports two directory layouts:
#   <operator>/operator/base/subscription.yaml  (nested operator/ structure)
#   <operator>/base/subscription.yaml            (flat structure)
# The second pass skips paths already matched by the first to avoid duplicates.
find_subscription_dirs() {
  find "${REPO_ROOT}" -maxdepth 4 -path '*/operator/base/subscription.yaml' -type f 2>/dev/null

  find "${REPO_ROOT}" -maxdepth 3 -path '*/base/subscription.yaml' -type f 2>/dev/null |
    while read -r f; do
      [[ "$f" == */operator/base/* ]] && continue
      echo "$f"
    done
}

# Resolves the overlays/ directory for a given subscription.yaml,
# navigating up to the operator root regardless of nesting depth.
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

# Lists the names of existing overlay subdirectories (each one maps to a channel).
get_existing_overlays() {
  local overlay_dir="$1"
  if [[ -d "$overlay_dir" ]]; then
    find "$overlay_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
  fi
}

# Extracts the top-level operator directory name from a subscription path.
# Accounts for both nested (operator/base/) and flat (base/) layouts.
get_operator_name() {
  local sub_file="$1"
  if [[ "$sub_file" == */operator/base/subscription.yaml ]]; then
    basename "$(dirname "$(dirname "$(dirname "$sub_file")")")"
  else
    basename "$(dirname "$(dirname "$sub_file")")"
  fi
}

# Creates a new channel overlay directory with two files:
#   kustomization.yaml - references the base and applies the channel patch
#   patch-channel.yaml - a JSON patch that sets spec.channel on the Subscription
create_overlay() {
  local sub_file="$1"
  local sub_name="$2"
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
      name: ${sub_name}
    path: patch-channel.yaml
YAML

  cat <<YAML >"${channel_dir}/patch-channel.yaml"
- op: replace
  path: /spec/channel
  value: ${channel}
YAML

  echo "    CREATED: ${channel_dir#"${REPO_ROOT}/"}"
}

# Removes a stale channel overlay directory entirely.
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

# Processes a single operator: reads its Subscription to determine the OLM
# package name and catalog source, fetches the available channels from the
# pre-loaded catalog data, and compares them against existing overlays.
# In "report" mode, prints differences; in "generate" mode, creates/removes
# overlay directories; in "list" mode, outputs the operator name if changed.
process_operator() {
  local sub_file="$1"
  local operator_name
  operator_name="$(get_operator_name "$sub_file")"

  for ignored in ${IGNORED_OPERATORS}; do
    if [[ "$operator_name" == "$ignored" ]]; then
      echo "SKIP: ${operator_name} (in IGNORED_OPERATORS)" >&2
      return
    fi
  done

  if [[ -n "$OPERATOR_FILTER" && "$operator_name" != "$OPERATOR_FILTER" ]]; then
    return
  fi

  # Read the Subscription metadata and spec fields
  local sub_name pkg_name catalog_source
  sub_name="$(yq '.metadata.name' "$sub_file")"
  pkg_name="$(yq '.spec.name' "$sub_file")"
  catalog_source="$(yq '.spec.source' "$sub_file")"

  # Verify the operator's catalog source is one we're tracking
  local is_tracked=false
  for catalog in ${CATALOGS}; do
    [[ "$catalog_source" == "$catalog" ]] && is_tracked=true && break
  done
  if [[ "$is_tracked" == "false" ]]; then
    if [[ "$IGNORE_MISSING" == "true" ]]; then
      MISSING_CATALOG_MSGS+=("SKIP: ${operator_name} references untracked catalog source '${catalog_source}'")
    else
      MISSING_CATALOG_MSGS+=("ERROR: ${operator_name} references unknown catalog source '${catalog_source}' (tracked: ${CATALOGS})")
      ERRORS=true
    fi
    return
  fi

  local catalog_channels
  catalog_channels="$(get_catalog_channels "$pkg_name" "$catalog_source")"

  if [[ -z "$catalog_channels" ]]; then
    if [[ "$IGNORE_MISSING" == "true" ]]; then
      MISSING_CATALOG_MSGS+=("SKIP: ${operator_name} package '${pkg_name}' not found in any ${catalog_source} index")
    else
      MISSING_CATALOG_MSGS+=("ERROR: ${operator_name} package '${pkg_name}' not found in any ${catalog_source} index (${OCP_VERSIONS})")
      ERRORS=true
    fi
    return
  fi

  local overlay_dir existing_overlays
  overlay_dir="$(get_overlay_dir "$sub_file")"
  existing_overlays="$(get_existing_overlays "$overlay_dir")"

  local missing_channels stale_channels
  missing_channels="$(comm -23 <(echo "$catalog_channels") <(echo "$existing_overlays") 2>/dev/null || true)"
  stale_channels="$(comm -13 <(echo "$catalog_channels") <(echo "$existing_overlays") 2>/dev/null || true)"

  # Nothing to report
  if [[ -z "$missing_channels" && -z "$stale_channels" ]]; then
    return
  fi

  HAS_CHANGES=true

  if [[ "$MODE" == "list" ]]; then
    echo "$operator_name"
    return
  fi

  echo "${operator_name} (package: ${pkg_name})"
  echo "  catalog channels:  $(echo "$catalog_channels" | tr '\n' ' ')"
  echo "  existing overlays: $(echo "$existing_overlays" | tr '\n' ' ')"

  if [[ -n "$missing_channels" ]]; then
    echo "  missing:           $(echo "$missing_channels" | tr '\n' ' ')"
    if [[ "$MODE" == "generate" ]]; then
      while IFS= read -r channel; do
        [[ -z "$channel" ]] && continue
        create_overlay "$sub_file" "$sub_name" "$channel"
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

  echo "Supported OCP versions: ${OCP_VERSIONS}" >&2
  echo "Catalogs: ${CATALOGS}" >&2
  echo "Mode: ${MODE}" >&2
  echo "" >&2

  # Phase 1: Build the complete channel dataset upfront so per-operator
  # lookups are fast jq filters against an in-memory string.
  echo "Extracting channel data from catalog indices..." >&2
  CHANNEL_DATA="$(extract_all_channel_data)"
  echo "Done. Checking operators..." >&2
  echo "" >&2

  # Phase 2: Walk every Subscription in the repo and compare its overlays
  # against the catalog data.
  while IFS= read -r sub_file; do
    [[ -z "$sub_file" ]] && continue
    process_operator "$sub_file"
  done < <(find_subscription_dirs | sort -u)

  if [[ ${#MISSING_CATALOG_MSGS[@]} -gt 0 ]]; then
    echo "Operators not found in catalog sources:" >&2
    for msg in "${MISSING_CATALOG_MSGS[@]}"; do
      echo "  ${msg}" >&2
    done
    echo "" >&2
  fi

  if [[ "$ERRORS" == "true" ]]; then
    echo "Errors were found — see above." >&2
    exit 1
  fi

  if [[ "$HAS_CHANGES" == "false" ]]; then
    echo "All operators are up to date — no missing or stale channel overlays found." >&2
  fi
}

main "$@"
