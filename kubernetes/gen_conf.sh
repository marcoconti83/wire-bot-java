#!/bin/bash

NAME="roller-config"

kubectl delete configmap $NAME
kubectl create configmap $NAME --from-file=../conf