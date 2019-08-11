helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install nginx-stable/nginx-ingress --name nginx-ingress-controller

# kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'