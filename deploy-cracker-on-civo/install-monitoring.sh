#!/bin/bash
export KUBECONFIG=$PWD/config/k3s.yaml
git clone https://github.com/prometheus-operator/kube-prometheus.git
cd kube-prometheus
rm -rf .git

kubectl apply --server-side -f manifests/setup
kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring
kubectl apply -f manifests/


