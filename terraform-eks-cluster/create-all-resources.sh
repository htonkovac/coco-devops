terraform apply -auto-approve  
$(terraform output kube-connect)
$(aws ecr get-login --no-include-email --region=eu-west-1)
terraform output | grep rds_| sed "s/ //g" > ./../kuberentes-resources/environment.env

echo "Setting up tiller" # This is done first because Tiller pods take a bit of time to provision
./../kuberentes-resources/setup-helm.sh
echo "..."

echo "Building and pushing docker images"
./../frontend-service/docker-build-and-push.sh
./../backend-service-1/docker-build-and-push.sh
echo "..."

sleep 10 #Waiting for tiller pods
echo "Setting up ingres-controller, cluster-autoscaler and metrcis server"
./../kuberentes-resources/setup-ingress-controller.sh
./../kuberentes-resources/setup-cluster-autoscaler.sh
./../kuberentes-resources/setup-metrics-server.sh 
echo "..."

kubectl kustomize ./../kuberentes-resources/ | kubectl apply -f -
kubectl get svc | awk '{if($1=="nginx-ingress-controller-controller")print $4}'
rm kuberentes-resources/environment.env