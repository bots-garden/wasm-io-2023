#!/bin/bash
set -o allexport; source .go.config; set +o allexport

export KUBECONFIG=$PWD/config/k3s.yaml
# Create a demo namespace
kubectl create namespace ${KUBE_NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

#envsubst < templates/deploy.tpl.yaml > tmp/deploy.${IMAGE_TAG}.yaml

kubectl delete -f tmp/deploy.${IMAGE_TAG}.yaml -n ${KUBE_NAMESPACE}
