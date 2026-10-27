# Week 5: Orchestration Frameworks and Automated Workflows

## 🎯 Learning Objectives

- Distinguish orchestration from configuration management and provisioning.
- Describe containerization fundamentals using Docker.
- Describe Kubernetes architecture: pods, deployments, services, and the control plane.
- Deploy and scale a containerized application using an orchestration platform.

## 🛠️ Hour 3 - Lab: Deploying and Scaling with Kubernetes

### Task

Install Minikube or Kind (Kubernetes in Docker) - both free, open-source, single-node Kubernetes distributions suitable for a laptop lab environment.

Write a Deployment manifest for a simple containerized application (e.g., a lightweight open-source web server image) and apply it with 'kubectl apply -f'.

Expose the deployment using a Service manifest and access the application locally through Minikube's tunnelling/port-forward features.

Scale the deployment by changing the 'replicas' field and re-applying, observing how Kubernetes automatically creates or removes pods to match the new desired state.

### ✅ Solution / Example Code

📄 **File:** `deployment.yaml`

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
        - name: web
          image: nginx:latest
          ports:
            - containerPort: 80

# Commands
# kubectl apply -f deployment.yaml
# kubectl scale deployment web-app --replicas=4
# kubectl get pods -w
```

> 💾 Saved in this folder: [`deployment.yaml`](deployment.yaml)

### 🧰 Recommended Open-Source / Free Tools

- Docker (free/open source Engine)
- Kubernetes (open source)
- Minikube or Kind (open source)
- kubectl (free)

## 📁 Files in this folder

- [`deployment.yaml`](deployment.yaml)

---
⬅️ [Back to Lecture Notes index](../README.md)
