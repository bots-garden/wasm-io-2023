#!/bin/bash
#export KUBECONFIG="$HOME/extism/config/k3s.yaml"
export KUBECONFIG="$HOME/extism/experiments/deploy-cracker/config/k3s.yaml"

KUBE_NAMESPACE="demo"
# Create namespace (if needed)
kubectl create namespace ${KUBE_NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

kubectl create -f load.cracker.yaml 
#kubectl apply -f load.cracker.yaml 
kubectl delete -f load.cracker.yaml 


#-n ${KUBE_NAMESPACE}
