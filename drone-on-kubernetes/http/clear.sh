#!/bin/bash
kubectl delete secrets drone-secrets
kubectl delete cm drone-config
kubectl delete -f ./
