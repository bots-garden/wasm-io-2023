#!/bin/bash
set -o allexport; source .env; set +o allexport

#civo apikey add civo-key ${CIVO_API_KEY}
#civo apikey current civo-key
civo --region=${CLUSTER_REGION} kubernetes list
# 🤔 does not work