#!/bin/bash
set -o allexport; source .env; set +o allexport

# Get the kubernetes config file
civo --region=${CLUSTER_REGION} \
kubernetes config ${CLUSTER_NAME} > ./config/k3s.yaml

