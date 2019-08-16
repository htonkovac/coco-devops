rbac:
  create: true

sslCertPath: /etc/ssl/certs/ca-bundle.crt

cloudProvider: aws
awsRegion: ${AWS_REGION}

autoDiscovery:
  clusterName: ${CLUSTER_NAME}
  enabled: true