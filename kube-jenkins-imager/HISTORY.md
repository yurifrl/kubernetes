#
- https://cloud.google.com/solutions/automated-build-images-with-jenkins-kubernetes
- https://github.com/GoogleCloudPlatform/kube-jenkins-imager

Login with user: jenkins and password ebXsCr00R5w2gKw8P7pK
bash-4.3# kubectl get ingress jenkins --namespace jenkins -o "jsonpath={.status.loadBalancer.ingress[0].ip}";echo
35.186.197.237

