helm install stable/nginx-ingress --name nginx-ingress-controller
helm install stable/cluster-autoscaler --values=cluster_autoscaler_values_`terraform output cluster_name`.yaml
helm install stable/metrics-server --name metrics-server --version 2.0.4 --namespace metrics
# helm install stable/cert-manager --name cert-manager --namespace kube-system --version v0.6.0 --set createCustomResource=true
helm install stable/cert-manager \
  --name cert-manager \
  --namespace kube-system \
  --version v0.5.2