#!/bin/sh

#assuming you are running on local minikube setup
export PROXY_IP=127.0.0.1
export PORT=8000

echo "Installing Kong using helm"

helm repo add kong https://charts.konghq.com

helm repo update

kubectl create namespace kong

helm install kic kong/kong -n kong -f kic.yaml

curl -i $PROXY_IP:$PORT

echo "Creating internal service and ingress"
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

curl -i http://kong.example:$PORT/echo --resolve kong.example:$PORT:$PROXY_IP

echo "Creating external service and ingress"
kubectl apply -f ext-service.yaml
kubectl apply -f ext-ingress.yaml

curl -i http://kong.example:$PORT/httpbin/anything --resolve kong.example:$PORT:$PROXY_IP
