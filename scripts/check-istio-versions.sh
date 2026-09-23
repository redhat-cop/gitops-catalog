#!/usr/bin/env bash
#
# Compares Istio version overlays for redhat-openshift-servicemesh-3/instance/
# against the versions published in the Sail operator's Istio CRD across
# Red Hat catalog indices.
#
# Phase 1: Renders the catalog index to find olm.channel and olm.bundle entries
#          for the target package, identifies the head bundle per channel, and
#          collects their bundle image references.
# Phase 2: Renders each unique bundle image with `opm render` to get the full
#          bundle content including the Istio CRD, then extracts the version
#          enum from the CRD's OpenAPI schema.
# Phase 3: Compares discovered versions against existing overlays.
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OCP_VERSIONS="${OCP_VERSIONS:-v4.18 v4.19 v4.20 v4.21 v4.22}"
MODE="${1:-report}" # report | generate
CATALOG_CACHE_DIR="${CATALOG_CACHE_DIR:-}"
BUNDLE_CACHE_DIR="${BUNDLE_CACHE_DIR:-}"
HAS_CHANGES=false

PACKAGE_NAME="${PACKAGE_NAME:-servicemeshoperator3}"
CATALOG="${CATALOG:-redhat-operators}"
CRD_KIND="${CRD_KIND:-Istio}"
INSTANCE_DIR="${INSTANCE_DIR:-${REPO_ROOT}/redhat-openshift-servicemesh-3/instance}"
OVERLAY_DIR="${INSTANCE_DIR}/overlays"

usage() {
  cat <<EOF
Usage: $(basename "$0") [report|generate]

Compares Istio version overlays in redhat-openshift-servicemesh-3/instance/
against the versions supported by the Sail operator's Istio CRD across Red Hat
catalog indices for multiple OCP versions.

Versions present in any supported OCP version but missing from the repo are
reported as missing. Existing overlays not present in any CRD are reported as
stale and removed in 'generate' mode.

The script works in two phases:
  1. Renders each OCP version's catalog index to find the head bundle per
     channel for the target package and collects their bundle image references.
  2. Renders each unique bundle image to extract the Istio CRD and reads the
     spec.version enum from its OpenAPI schema.

Environment variables:
  OCP_VERSIONS       Space-separated list of OCP versions (default: v4.18 v4.19 v4.20 v4.21 v4.22)
  CATALOG            Catalog source name (default: redhat-operators)
  PACKAGE_NAME       OLM package name (default: servicemeshoperator3)
  CRD_KIND           CRD kind to extract version enum from (default: Istio)
  INSTANCE_DIR       Path to the instance directory (default: <repo>/redhat-openshift-servicemesh-3/instance)
  CATALOG_CACHE_DIR  Directory containing catalog index JSON files named
                     <catalog>-<version>.json (raw or package-filtered opm
                     render output — must include olm.channel and olm.bundle
                     entries, NOT the channel-only format used by
                     check-catalog-channels.sh)
  BUNDLE_CACHE_DIR   Directory containing pre-rendered bundle JSON files.
                     Each file is named by the bundle digest (sha256-<hash>.json)
                     and contains the output of 'opm render <bundle-image>'.

Requires: jq, yq, and opm (opm only when cache dirs are not set)
EOF
}

check_prereqs() {
  local missing=()
  for cmd in jq yq; do
    command -v "$cmd" &>/dev/null || missing+=("$cmd")
  done
  if [[ -z "${CATALOG_CACHE_DIR:-}" || -z "${BUNDLE_CACHE_DIR:-}" ]]; then
    command -v opm &>/dev/null || missing+=("opm")
  fi
  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "ERROR: missing required tools: ${missing[*]}" >&2
    exit 1
  fi
}

get_catalog_image_base() {
  local catalog="$1"
  local index_name="${catalog%-operators}-operator-index"
  echo "registry.redhat.io/redhat/${index_name}"
}

# Extracts all FBC entries for the target package from a single catalog+version
# combination. Uses cached JSON if CATALOG_CACHE_DIR is set; otherwise renders
# the catalog image live with `opm render`.
# Output: one JSON object per line (olm.channel and olm.bundle entries).
extract_package_data_for_version() {
  local version="$1"
  local cache_file="${CATALOG_CACHE_DIR:+${CATALOG_CACHE_DIR}/${CATALOG}-${version}.json}"
  local jq_filter
  jq_filter="$(printf 'select(.package == "%s" and (.schema == "olm.channel" or .schema == "olm.bundle"))' "$PACKAGE_NAME")"

  if [[ -n "${cache_file}" && -f "${cache_file}" ]]; then
    echo "  Using cached catalog: ${cache_file}" >&2
    jq -c "$jq_filter" < "${cache_file}"
  else
    local image_base
    image_base="$(get_catalog_image_base "$CATALOG")"
    local image="${image_base}:${version}"
    echo "  Rendering catalog ${image}..." >&2
    opm render "${image}" | jq -c "$jq_filter"
  fi
}

# Given FBC data (olm.channel + olm.bundle entries) on stdin, finds the head
# bundle name for each channel and outputs the corresponding bundle image
# references (one per line). The head is the entry whose name is not listed
# as 'replaces' by any other entry in the same channel.
extract_head_bundle_images() {
  jq -r -s '
    . as $all |

    # Build a map of bundle name -> image from olm.bundle entries
    ([.[] | select(.schema == "olm.bundle")] |
      reduce .[] as $b ({}; . + {($b.name): $b.image})) as $images |

    # For each channel, find the head (not replaced by any other entry)
    $all | [.[] | select(.schema == "olm.channel")] | .[] |
    .entries as $entries |
    ($entries | map(.replaces // empty)) as $replaced |
    $entries[] |
    select(.name as $n | ($replaced | index($n)) == null) |
    $images[.name] // empty
  '
}

# Renders a bundle image and extracts Istio version strings from its CRD.
# Uses cached bundle JSON if BUNDLE_CACHE_DIR is set.
# Output: one version string per line.
extract_versions_from_bundle_image() {
  local bundle_image="$1"
  local bundle_json=""

  # Derive cache filename from the image digest
  local digest=""
  if [[ "$bundle_image" == *"@sha256:"* ]]; then
    digest="${bundle_image##*@sha256:}"
  fi
  local cache_file="${BUNDLE_CACHE_DIR:+${BUNDLE_CACHE_DIR}/sha256-${digest}.json}"

  if [[ -n "${cache_file}" && -n "${digest}" && -f "${cache_file}" ]]; then
    echo "    Using cached bundle: ${cache_file}" >&2
    bundle_json="$(cat "${cache_file}")"
  else
    echo "    Rendering bundle ${bundle_image}..." >&2
    bundle_json="$(opm render "${bundle_image}")"
  fi

  echo "$bundle_json" | jq -r --arg kind "$CRD_KIND" '
    .properties[]? |
    select(.type == "olm.bundle.object") |
    .value.data |
    @base64d |
    fromjson |
    select(
      .kind == "CustomResourceDefinition" and
      .spec.names.kind == $kind
    ) |
    .spec.versions[]? |
    .schema.openAPIV3Schema.properties.spec.properties.version.enum[]?
  '
}

# Collects head bundle images across all OCP versions and deduplicates,
# then renders each unique bundle to extract version data.
extract_all_versions() {
  local all_bundle_images=""

  echo "Phase 1: Finding head bundles from catalog indices..." >&2
  for version in ${OCP_VERSIONS}; do
    echo "Processing ${CATALOG} ${version}..." >&2
    local package_data head_images
    package_data="$(extract_package_data_for_version "$version")"
    if [[ -n "$package_data" ]]; then
      head_images="$(echo "$package_data" | extract_head_bundle_images)"
      if [[ -n "$head_images" ]]; then
        if [[ -n "$all_bundle_images" ]]; then
          all_bundle_images="${all_bundle_images}"$'\n'"${head_images}"
        else
          all_bundle_images="${head_images}"
        fi
      fi
    fi
  done

  local unique_images
  unique_images="$(echo "$all_bundle_images" | sort -u)"

  if [[ -z "$unique_images" ]]; then
    echo "ERROR: no bundle images found for package '${PACKAGE_NAME}' in any ${CATALOG} index (${OCP_VERSIONS})" >&2
    exit 1
  fi

  local image_count
  image_count="$(echo "$unique_images" | wc -l)"
  echo "" >&2
  echo "Phase 2: Extracting ${CRD_KIND} versions from ${image_count} unique bundle image(s)..." >&2

  local combined=""
  while IFS= read -r image; do
    [[ -z "$image" ]] && continue
    local version_data
    version_data="$(extract_versions_from_bundle_image "$image")"
    if [[ -n "$version_data" ]]; then
      if [[ -n "$combined" ]]; then
        combined="${combined}"$'\n'"${version_data}"
      else
        combined="${version_data}"
      fi
    fi
  done <<<"$unique_images"

  if [[ -z "$combined" ]]; then
    echo "ERROR: no ${CRD_KIND} versions found in any bundle for '${PACKAGE_NAME}'" >&2
    echo "  Ensure the ${CRD_KIND} CRD has a version enum in its OpenAPI schema." >&2
    exit 1
  fi

  echo "$combined" | sort -u
}

get_existing_overlays() {
  if [[ -d "$OVERLAY_DIR" ]]; then
    find "$OVERLAY_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
  fi
}

# Creates a new version overlay directory with two files:
#   kustomization.yaml - references the base and applies the version patch
#                        to both Istio and IstioCNI resources
#   patch-version.yaml - a JSON patch that sets spec.version
create_overlay() {
  local version="$1"
  local version_dir="${OVERLAY_DIR}/${version}"

  mkdir -p "${version_dir}"

  cat <<YAML >"${version_dir}/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

patches:
  - target:
      kind: IstioCNI
      name: default
    path: patch-version.yaml
  - target:
      kind: Istio
      name: default
    path: patch-version.yaml
YAML

  cat <<YAML >"${version_dir}/patch-version.yaml"
- op: replace
  path: /spec/version
  value: ${version}
YAML

  echo "  CREATED: ${version_dir#"${REPO_ROOT}/"}"
}

remove_overlay() {
  local version="$1"
  local version_dir="${OVERLAY_DIR}/${version}"

  if [[ -d "${version_dir}" ]]; then
    rm -rf "${version_dir}"
    echo "  REMOVED: ${version_dir#"${REPO_ROOT}/"}"
  fi
}

# Compares discovered versions against existing overlays.
process_versions() {
  local catalog_versions="$1"
  local existing_overlays
  existing_overlays="$(get_existing_overlays)"

  local missing_versions stale_versions
  missing_versions="$(comm -23 <(echo "$catalog_versions") <(echo "$existing_overlays") 2>/dev/null || true)"
  stale_versions="$(comm -13 <(echo "$catalog_versions") <(echo "$existing_overlays") 2>/dev/null || true)"

  if [[ -z "$missing_versions" && -z "$stale_versions" ]]; then
    return
  fi

  HAS_CHANGES=true

  echo "redhat-openshift-servicemesh-3/instance (package: ${PACKAGE_NAME})"
  echo "  catalog versions:  $(echo "$catalog_versions" | tr '\n' ' ')"
  echo "  existing overlays: $(echo "$existing_overlays" | tr '\n' ' ')"

  if [[ -n "$missing_versions" ]]; then
    echo "  missing:           $(echo "$missing_versions" | tr '\n' ' ')"
    if [[ "$MODE" == "generate" ]]; then
      while IFS= read -r version; do
        [[ -z "$version" ]] && continue
        create_overlay "$version"
      done <<<"$missing_versions"
    fi
  fi

  if [[ -n "$stale_versions" ]]; then
    echo "  stale:             $(echo "$stale_versions" | tr '\n' ' ')"
    if [[ "$MODE" == "generate" ]]; then
      while IFS= read -r version; do
        [[ -z "$version" ]] && continue
        remove_overlay "$version"
      done <<<"$stale_versions"
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
  echo "Catalog: ${CATALOG}" >&2
  echo "Package: ${PACKAGE_NAME}" >&2
  echo "CRD kind: ${CRD_KIND}" >&2
  echo "Mode: ${MODE}" >&2
  echo "" >&2

  echo "Extracting ${CRD_KIND} versions from catalog bundles..." >&2
  local all_versions
  all_versions="$(extract_all_versions)"
  echo "Done. Found versions: $(echo "$all_versions" | tr '\n' ' ')" >&2
  echo "" >&2

  process_versions "$all_versions"

  if [[ "$HAS_CHANGES" == "false" ]]; then
    echo "All version overlays are up to date — no missing or stale overlays found." >&2
  fi
}

main "$@"
