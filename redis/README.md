
kubectl create secret generic secrets --from-file=./secrets
kubectl get secrets secrets -o yaml >> secrets.yml
