#!/bin/bash
set -o allexport; source .env; set +o allexport

civo --region=${CLUSTER_REGION} kubernetes applications add Traefik-v2-nodeport --cluster=${CLUSTER_NAME}