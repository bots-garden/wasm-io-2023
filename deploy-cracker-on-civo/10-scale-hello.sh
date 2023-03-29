#!/bin/bash
set -o allexport; source .go.config; set +o allexport

export KUBECONFIG=$PWD/config/k3s.yaml

REPLICAS=10
kubectl scale --replicas=${REPLICAS} deploy ${APPLICATION_NAME} -n ${KUBE_NAMESPACE}
