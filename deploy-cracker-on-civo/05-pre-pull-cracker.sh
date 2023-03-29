#!/bin/bash
export KUBECONFIG=$PWD/config/k3s.yaml

KUBE_NAMESPACE="demo"
# Create namespace (if needed)
kubectl create namespace ${KUBE_NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

kubectl create -f ./tools/load.cracker.yaml 
#kubectl apply -f ./tools/load.cracker.yaml 
kubectl delete -f ./tools/load.cracker.yaml 
