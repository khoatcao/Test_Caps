#!/bin/bash

eksctl create cluster --name $EKS_CLUSTER_NAME \
                      --version 1.27 \
                      --nodegroup-name standard-workers \
                      --node-type t2.medium \
                      --nodes 2 \
                      --nodes-min 1 \
                      --nodes-max 2 \
                      --node-ami auto \
                      --region $AWS_REGION

sleep 2m
aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION
kubectl config use-context $EKS_CLUSTER_NAME
kubectl config current-context
kubectl apply -f deploy-k8s.yml
kubectl rollout restart deployment/simple-web-app
sleep 2m
kubectl get nodes
kubectl get deployments
kubectl get pods -o wide
kubectl get service/simple-web-app
