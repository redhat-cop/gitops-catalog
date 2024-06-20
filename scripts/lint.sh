#!/bin/bash
# shellcheck disable=SC2015,SC1091
set -e

usage(){
  echo "
  usage: $0
  "
}

py_setup_venv(){
  python3 -m venv venv
  source venv/bin/activate
  pip install -q -U pip

  py_check_venv || usage
}

py_check_venv(){
  # activate python venv
  [ -d venv ] && . venv/bin/activate || py_setup_venv
  [ -e requirements.txt ] && pip install -q -r requirements.txt
}

py_bin_checks(){
  which python || exit 0
  which pip || exit 0
}

lint_spelling(){
  which aspell || return
  which pyspelling || return
  [ -e .pyspelling.yml ] || return
  [ -e .wordlist-md ] || return

  pyspelling -c .pyspelling.yml
}

lint_scripts(){
  which shellcheck || return
  find . -not \( -path '*/venv/*' -o -path '*/scratch/*' \) -name '*.sh'  -print0 | xargs -0 shellcheck
}

lint_dockerfiles(){
  which hadolint || return
  find . -not -path "./scratch/*" \( -name Dockerfile -o -name Containerfile \) -exec hadolint {} \;
}

lint_yaml(){
  which yamllint || return
  yamllint . || return
  echo "YAML check passed :)"
}

lint_kustomize(){
  [ -e scripts/validate_kustomize.sh ] || return
  scripts/validate_kustomize.sh
}

lint_helm(){
  [ -e scripts/validate_helm.sh ] || return
  scripts/validate_helm.sh
}

py_check_venv
py_bin_checks

lint_spelling     || exit 1
lint_scripts      || exit 1
lint_dockerfiles  || exit 1
lint_yaml         || exit 1
lint_kustomize    || exit 1
lint_helm         || exit 1
