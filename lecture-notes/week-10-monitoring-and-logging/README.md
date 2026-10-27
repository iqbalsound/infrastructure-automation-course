# Week 10: Monitoring and Logging in Automated Infrastructure

## 🎯 Learning Objectives

- Explain the three pillars of observability: metrics, logs, and traces.
- Describe Prometheus's architecture for metrics collection and alerting.
- Describe how Grafana is used to visualize metrics through dashboards.
- Deploy and configure a monitoring stack in a lab environment.

## 🛠️ Hour 3 - Lab: Deploying a Monitoring Stack

### Task

Install Helm (the open-source Kubernetes package manager) and use the community 'kube-prometheus-stack' Helm chart to deploy Prometheus, Alertmanager, and Grafana onto the Minikube/Kind cluster used in Weeks 5 and 9.

Access the Grafana UI (via port-forward) using the default open-source dashboard bundled with the chart, and explore pre-built dashboards showing cluster and pod resource usage.

Create one custom Grafana panel visualizing CPU usage for the Week 5/9 web-app deployment, connecting the visualization directly to the auto-scaling behavior observed last week.

Define a simple Prometheus alerting rule (e.g., alert if a pod's CPU usage exceeds a threshold for more than two minutes) and confirm it appears correctly in the Alertmanager UI.

### ✅ Solution / Example Code

📄 **File:** `install-monitoring.sh`

```bash
# Install monitoring stack via Helm (open source)
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack

# Access Grafana locally
kubectl port-forward svc/monitoring-grafana 3000:80
```

> 💾 Saved in this folder: [`install-monitoring.sh`](install-monitoring.sh)

📄 **File:** `alert-rules.yaml`

```yaml
# Example Prometheus alert rule (YAML). With kube-prometheus-stack, place it inside a PrometheusRule resource (spec.groups).
groups:
  - name: web-app-alerts
    rules:
      - alert: HighCPUUsage
        expr: sum by (pod) (rate(container_cpu_usage_seconds_total{pod=~"web-app.*"}[2m])) > 0.8
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage detected on web-app pod"
```

> 💾 Saved in this folder: [`alert-rules.yaml`](alert-rules.yaml)

### 🧰 Recommended Open-Source / Free Tools

- Prometheus (open source)
- Grafana (open source)
- Alertmanager (open source)
- Helm (open source)

## 📁 Files in this folder

- [`install-monitoring.sh`](install-monitoring.sh)
- [`alert-rules.yaml`](alert-rules.yaml)

---
⬅️ [Back to Lecture Notes index](../README.md)
