#!/bin/bash
set -o allexport; source .env; set +o allexport

export KUBECONFIG=$PWD/config/k3s.yaml

civo apikey add civo-key ${CIVO_API_KEY}
civo apikey current civo-key

civo kubernetes remove ${CLUSTER_NAME} --region=${CLUSTER_REGION} --yes 
