# Week 9: Automated Provisioning and Scaling

## 🎯 Learning Objectives

- Explain horizontal and vertical scaling and the triggers that initiate automated scaling.
- Describe how Kubernetes implements automated scaling through the Horizontal Pod Autoscaler and cluster auto-scaling concepts.
- Configure and test an auto scaling policy in a lab environment.
- Evaluate the trade-offs of automated scaling decisions under load.

## 🛠️ Hour 3 - Lab: Configuring the Horizontal Pod Autoscaler

### Task

Enable the metrics-server add-on in Minikube (or install it in Kind) and confirm metrics are being reported using 'kubectl top pods'. Because the HPA calculates utilization as a percentage of each container's CPU request, first confirm that the Deployment declares one (the Week 5 manifest did not); for example, run 'kubectl set resources deployment web-app --requests=cpu=100m'. Without a CPU request the HPA reports <unknown> for its target.

Define an HPA resource targeting the Week 5 Deployment, specifying minimum and maximum replica counts and a target CPU utilization percentage.

Generate synthetic CPU load against the deployed application (e.g., using a small open-source load-generation tool or a simple busy-loop script) and observe, using 'kubectl get hpa -w', the replica count increasing automatically.

Stop the load generator and observe the scale-down behavior, discussing the default cool-down/stabilisation window Kubernetes applies to avoid thrashing.

### ✅ Solution / Example Code

📄 **File:** `hpa.yaml`

```yaml
# hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  minReplicas: 2
  maxReplicas: 6
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50

# Prerequisite: the HPA measures utilization against each container's CPU *request*
# kubectl set resources deployment web-app --requests=cpu=100m

# Commands
# kubectl apply -f hpa.yaml
# kubectl get hpa -w
# kubectl top pods
```

> 💾 Saved in this folder: [`hpa.yaml`](hpa.yaml)

### 🧰 Recommended Open-Source / Free Tools

- Kubernetes (open source)
- Minikube/Kind
- metrics-server (open source)
- hey or k6 (open source load-testing tools)

## 📁 Files in this folder

- [`hpa.yaml`](hpa.yaml)

---
⬅️ [Back to Lecture Notes index](../README.md)
