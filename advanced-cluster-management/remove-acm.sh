#!/bin/bash

if [ -z "${OPERATOR_NAMESPACE}" ]; then
	OPERATOR_NAMESPACE="open-cluster-management"
fi

if [ -z "${KLUSTERLET_NAMESPACE}" ]; then
	KLUSTERLET_NAMESPACE="open-cluster-management-hub"
fi

KUBECTL=oc

# Force delete klusterlet
echo "attempt to delete klusterlet"
"${KUBECTL}" delete klusterlet klusterlet --timeout=60s
"${KUBECTL}" delete namespace "${KLUSTERLET_NAMESPACE}" --wait=false
echo "force removing klusterlet"
"${KUBECTL}" patch klusterlet klusterlet --type="json" -p '[{"op": "remove", "path":"/metadata/finalizers"}]'
echo "removing klusterlet crd"
"${KUBECTL}" delete crd klusterlets.operator.open-cluster-management.io --timeout=30s

# managedclustermutators.admission.cluster.open-cluster-management.io

# force delete all validating webhook configuration
# oc get validatingwebhookconfigurations -o name | egrep 'cluster-management.io|multicluster'
component_vwc=(
  managedclustersetbindingv1beta1validators.admission.cluster.open-cluster-management.io
  managedclustersetbindingvalidators.admission.cluster.open-cluster-management.io
  managedclustervalidators.admission.cluster.open-cluster-management.io
  manifestworkvalidators.admission.work.open-cluster-management.io
  multiclusterengines.multicluster.openshift.io
  multiclusterhub-operator-validating-webhook
  multicluster-observability-operator
)

for vwc in "${component_vwc[@]}"
do
  echo "delete validatingwebhookconfigurations ${vwc} resources..."
  "${KUBECTL}" delete validatingwebhookconfigurations "${vwc}"
done

# Force delete all component CRDs if they still exist
# oc get crd -o name | grep cluster-management.io
component_crds=(
  baremetalassets.inventory.open-cluster-management.io
  channels.apps.open-cluster-management.io
  clustermanagementaddons.addon.open-cluster-management.io
  clustermanagers.operator.open-cluster-management.io
  deployables.apps.open-cluster-management.io
  helmreleases.apps.open-cluster-management.io
  klusterletaddonconfigs.agent.open-cluster-management.io
  managedclusteractions.action.open-cluster-management.io
  managedclusteraddons.addon.open-cluster-management.io
  managedclusterinfos.internal.open-cluster-management.io
  managedclusters.cluster.open-cluster-management.io
  managedclustersetbindings.cluster.open-cluster-management.io
  managedclustersets.cluster.open-cluster-management.io
  managedclusterviews.view.open-cluster-management.io
  manifestworks.work.open-cluster-management.io
  mirroredmanagedclusters.cluster.open-cluster-management.io
  multiclusterhubs.operator.open-cluster-management.io
  multiclusterobservabilities.observability.open-cluster-management.io
  observabilityaddons.observability.open-cluster-management.io
  placementbindings.policy.open-cluster-management.io
  placementrules.apps.open-cluster-management.io
  policies.policy.open-cluster-management.io
  searches.search.open-cluster-management.io
  searchcustomizations.search.open-cluster-management.io
  searchoperators.search.open-cluster-management.io
  submarinerconfigs.submarineraddon.open-cluster-management.io
  subscriptions.apps.open-cluster-management.io
  userpreferences.console.open-cluster-management.io
)

for crd in "${component_crds[@]}"; do
	echo "force delete all CustomResourceDefinition ${crd} resources..."
	for resource in $("${KUBECTL}" get "${crd}" -o name -n "${OPERATOR_NAMESPACE}")
  do
		echo "attempt to delete ${crd} resource ${resource}..."
		"${KUBECTL}" delete "${resource}" -n "${OPERATOR_NAMESPACE}" --timeout=30s
		echo "force remove ${crd} resource ${resource}..."
		"${KUBECTL}" patch "${resource}" -n "${OPERATOR_NAMESPACE}" --type="json" -p '[{"op": "remove", "path":"/metadata/finalizers"}]'
	done
	echo "force delete all CustomResourceDefinition ${crd} resources..."
	"${KUBECTL}" delete crd "${crd}"
done

"${KUBECTL}" delete namespace "${OPERATOR_NAMESPACE}"
