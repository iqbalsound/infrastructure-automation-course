# Lab 8: Automated Monitoring and Logging

|  |  |
|---|---|
| **Week** | 10 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | Prometheus; Grafana; node_exporter; Docker |
| **Estimated Time** | 120 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain the role of automated monitoring and logging in infrastructure reliability.
- Deploy Prometheus to scrape metrics from a running service.
- Build a Grafana dashboard and an alert rule that visualize and watch those metrics.
- Inspect container logs and explain why centralized logging matters.

## 2. Preamble / Short Theory

Prometheus (open source, CNCF) and Grafana (open source) are the de facto standard, freely self-hostable monitoring stack. Prometheus pulls (scrapes) metrics from HTTP endpoints; Grafana visualizes them and can raise alerts. All containers join one Docker network and find each other by name, which works identically on Linux, macOS, and Windows (the name `host.docker.internal` does not exist on Linux by default).

This lab concentrates on metrics. Log aggregation (for example with Grafana Loki) is discussed in the Week 10 lecture and can be explored as an extension.

## 3. Prerequisites

- Docker installed.
- Lab 5 or Lab 6 completed (a running containerized service is helpful but not required).

## 4. Step-by-Step Guide

### Step 1: Create the Prometheus configuration

In a new folder `lab08-monitoring`, create `prometheus.yml`.

📄 **File:** `prometheus.yml`

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['node-exporter:9100']
```

> 💾 Saved in this folder: [`prometheus.yml`](prometheus.yml)

### Step 2: Start the monitoring stack

```bash
docker network create monitoring
docker run -d --name node-exporter --network monitoring -p 9100:9100 prom/node-exporter
docker run -d --name prometheus --network monitoring -p 9090:9090 \
  -v "$(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml:ro" \
  prom/prometheus
docker run -d --name grafana --network monitoring -p 3000:3000 grafana/grafana
```

### Step 3: Verify the targets

Browse to http://127.0.0.1:9090/targets and confirm that both the `prometheus` and `node` targets show state UP.

### Step 4: Query metrics

In the Prometheus expression browser, run the two queries below and note what each returns.

```promql
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[2m])) * 100)
```

```promql
node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100
```

### Step 5: Add Prometheus as a Grafana data source

Open http://127.0.0.1:3000 (login `admin` / `admin`, then set a new password). Add a Prometheus data source with URL `http://prometheus:9090` and click Save and Test.

### Step 6: Build a dashboard

Create a dashboard with two panels, CPU usage and memory available, using the queries from Step 4 (or `node_cpu_seconds_total` and `node_memory_MemAvailable_bytes` directly). Set the refresh to 15 seconds.

### Step 7: Set an alert rule

Create a Grafana alert that fires when memory availability falls below a threshold you choose, with a pending period of 2 minutes. Document the threshold and your rationale.

### Step 8: Inspect logs

```bash
docker logs --tail 20 prometheus
docker logs --since 5m grafana | head -n 20
```

Explain in two sentences why reading logs one container at a time would not scale to fifty containers.

### Step 9: Export the dashboard

Use Dashboard settings, JSON Model, and save the JSON to `dashboard.json`.

## 5. Your Tasks / Required Outcomes

- `prometheus.yml` and `dashboard.json`.
- A dated screenshot of the Prometheus targets page showing UP status and of the live Grafana dashboard.
- Your chosen alert threshold with a one-paragraph justification.

## 📁 Files in this folder

- [`prometheus.yml`](prometheus.yml)

---
⬅️ [Back to Lab Manual index](../README.md)
