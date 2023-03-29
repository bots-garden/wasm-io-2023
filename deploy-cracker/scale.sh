#!/bin/bash
set -o allexport; source deploy.config; set +o allexport

#export KUBECONFIG="$HOME/extism/config/k3s.yaml"
export KUBECONFIG="$HOME/extism/experiments/deploy-cracker/config/k3s.yaml"

KUBE_NAMESPACE="demo"

REPLICAS=5
kubectl scale --replicas=${REPLICAS} deploy ${APPLICATION_NAME} -n ${KUBE_NAMESPACE}
