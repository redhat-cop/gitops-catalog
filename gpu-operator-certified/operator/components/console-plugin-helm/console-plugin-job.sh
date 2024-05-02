#!/usr/bin/env bash

enable_console_plugin(){
  [ -z "${PLUGIN_NAME}" ] && return 1

  echo "Attempting to enable ${PLUGIN_NAME} plugin"
  echo ""

  # Create the plugins section on the object if it doesn't exist
  if [ -z "$(oc get consoles.operator.openshift.io cluster -o=jsonpath='{.spec.plugins}')" ]; then
    echo "Creating plugins object"
    oc patch consoles.operator.openshift.io cluster --patch '{ "spec": { "plugins": [] } }' --type=merge
  fi

  INSTALLED_PLUGINS=$(oc get consoles.operator.openshift.io cluster -o=jsonpath='{.spec.plugins}')
  echo "Current plugins:"
  echo "${INSTALLED_PLUGINS}"

  if [[ "${INSTALLED_PLUGINS}" == *"${PLUGIN_NAME}"* ]]; then
      echo "${PLUGIN_NAME} is already enabled"
  else
      echo "Enabling plugin: ${PLUGIN_NAME}"
      oc patch consoles.operator.openshift.io cluster --type=json --patch '[{"op": "add", "path": "/spec/plugins/-", "value": "'"${PLUGIN_NAME}"'"}]'
  fi

  sleep 6
  oc get consoles.operator.openshift.io cluster -o=jsonpath='{.spec.plugins}'
}

enable_console_plugin
