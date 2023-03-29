#!/bin/bash
set -o allexport; source .go.config; set +o allexport

export KUBECONFIG=$PWD/config/k3s.yaml
# Create a demo namespace
kubectl create namespace ${KUBE_NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

envsubst < templates/deploy.tpl.yaml > tmp/deploy.${IMAGE_TAG}.yaml

kubectl apply -f tmp/deploy.${IMAGE_TAG}.yaml -n ${KUBE_NAMESPACE}

kubectl describe ingress hello-wasm-io -n ${KUBE_NAMESPACE}
