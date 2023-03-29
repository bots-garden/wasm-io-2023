#!/bin/bash
set -o allexport; source deploy.config; set +o allexport

#export KUBECONFIG="$HOME/extism/config/k3s.yaml"
export KUBECONFIG="$HOME/extism/experiments/deploy-cracker/config/k3s.yaml"


KUBE_NAMESPACE="demo"
# Create namespace
kubectl create namespace ${KUBE_NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

envsubst < templates/deploy.tpl.yaml > tmp/deploy.${IMAGE_TAG}.yaml

kubectl apply -f tmp/deploy.${IMAGE_TAG}.yaml -n ${KUBE_NAMESPACE}
