terraform apply -auto-approve  
$(terraform output kube-connect)
$(aws ecr get-login --no-include-email --region=eu-west-1)

./../frontend-service/docker-build-and-push.sh
./../backend-service-1/docker-build-and-push.sh

./../kuberentes-resources/setup-helm.sh
./../kuberentes-resources/setup-ingress-controller.sh

kubectl apply -f  ./../kuberentes-resources/
kubectl get svc | awk '{if($1=="nginx-ingress-controller-controller")print $4}'