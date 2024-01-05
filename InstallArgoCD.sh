#!/bin/bash

# Check if ArgoCD custom resource already exists
if kubectl get pods -n argocd | grep argocd-server &> /dev/null; then
    echo "ArgoCD is already installed. Skipping installation."
else
    echo "ArgoCD is not installed. Installing now..."
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    echo "ArgoCD installation complete."
fi
