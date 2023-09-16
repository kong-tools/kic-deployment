#!/bin/sh

kubectl create secret generic kong-enterprise-license --from-file=license=./license.json -n kong

kubectl create secret generic kong-enterprise-superuser-password -n kong --from-literal=password=password

openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) \
    -keyout ./cluster.key -out ./cluster.crt \
    -days 1095 -subj "/CN=*.jwconsult.com"

kubectl create secret tls domain-tls-secret --cert=cluster.crt --key=cluster.key -n kong
