#!/bin/bash
set -o allexport; source .env; set +o allexport

mkdir -p config
export KUBECONFIG=$PWD/config/k3s.yaml

# Add the key to the CLI tool
civo apikey add civo-key ${CIVO_API_KEY}
civo apikey current civo-key

# Create the cluster
civo kubernetes create ${CLUSTER_NAME} \
--size=${CLUSTER_SIZE} \
--nodes=${CLUSTER_NODES} \
--region=${CLUSTER_REGION} \
--applications=Traefik-v2-nodeport \
--wait

# Get the kubernetes config file
civo --region=${CLUSTER_REGION} \
kubernetes config ${CLUSTER_NAME} > ./config/k3s.yaml
