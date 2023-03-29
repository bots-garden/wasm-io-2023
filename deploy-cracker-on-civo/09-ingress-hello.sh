#!/bin/bash
set -o allexport; source .go.config; set +o allexport

export KUBECONFIG=$PWD/config/k3s.yaml

#envsubst < templates/deploy.tpl.yaml > tmp/deploy.${IMAGE_TAG}.yaml

kubectl describe ingress ${APPLICATION_NAME} -n ${KUBE_NAMESPACE}
