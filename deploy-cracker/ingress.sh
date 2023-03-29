#!/bin/bash
set -o allexport; source deploy.config; set +o allexport

#export KUBECONFIG="$HOME/extism/config/k3s.yaml"
export KUBECONFIG="$HOME/extism/experiments/deploy-cracker/config/k3s.yaml"

#envsubst < templates/deploy.tpl.yaml > tmp/deploy.${IMAGE_TAG}.yaml

kubectl describe ingress hello-wasm-io -n ${KUBE_NAMESPACE}
