#!/bin/bash
#set -o allexport; source deploy.config; set +o allexport

#export KUBECONFIG="$HOME/extism/config/k3s.yaml"
export KUBECONFIG="$HOME/extism/experiments/deploy-cracker/config/k3s.yaml"

APPLICATION_NAME="hello-wasm-io"
KUBE_NAMESPACE="demo"

#kubectl exec ${APPLICATION_NAME} -- printenv -n ${KUBE_NAMESPACE}

kubectl set env deployment/${APPLICATION_NAME} -n ${KUBE_NAMESPACE} \
FUNCTION_NAME="helloWorld" \
WASM_FILE="./tmp/hello-go.wasm" \
WASM_URI="/api/v4/projects/43900010/packages/generic/go_wasm_io/0.0.1/hello-go.wasm"

