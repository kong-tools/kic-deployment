#!/bin/sh

echo "Cleaning up the installation of kong and resources"

helm uninstall kic -n kong
kubectl delete -f ingress.yaml
kubectl delete -f service.yaml

kubectl delete -f ext-ingress.yaml
kubectl delete -f ext-service.yaml

echo "Cleaned up"
