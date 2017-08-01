kubectl create secret generic redalert-config --from-file=./config.json
kubectl get secrets redalert-config -o yaml >> secrets.yml
kubectl apply -f .
