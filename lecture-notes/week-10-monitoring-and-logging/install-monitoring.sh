# Install monitoring stack via Helm (open source)
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack

# Access Grafana locally
kubectl port-forward svc/monitoring-grafana 3000:80
