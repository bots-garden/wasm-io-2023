#!/bin/bash
export KUBECONFIG="$HOME/extism/experiments/deploy-cracker/config/k3s.yaml"
k9s --all-namespaces
