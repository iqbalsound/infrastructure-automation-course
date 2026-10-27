# Lab 5: Container Orchestration Basics

|  |  |
|---|---|
| **Week** | 5 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | Docker; Kubernetes via Minikube; kubectl |
| **Estimated Time** | 90 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain the role of container orchestration in automated infrastructure.
- Deploy a containerized application to a local Kubernetes cluster.
- Scale, update, roll back, and observe self-healing using kubectl.

## 2. Preamble / Short Theory

Kubernetes (open source, CNCF, Apache 2.0) automates deployment, scaling, and recovery of containerized applications by continuously reconciling actual state with the desired state you declare. Minikube runs a single-node cluster on your laptop, so no cloud account or billing is involved.

## 3. Prerequisites

- Lab 1 completed (general command-line comfort).
- Docker installed and running.
- Minikube and kubectl installed (both open source).

## 4. Step-by-Step Guide

### Step 1: Start Minikube

```bash
minikube start --driver=docker
```

### Step 2: Verify the cluster

```bash
kubectl get nodes
kubectl cluster-info
```

### Step 3: Deploy a sample application

```bash
kubectl create deployment web --image=nginx:stable
kubectl expose deployment web --port=80 --type=NodePort
kubectl get deployments,pods,services
```

### Step 4: Access the service

With the Docker driver on macOS and Windows, this command must be left running in its own terminal while you test.

```bash
minikube service web --url
```

### Step 5: Scale the deployment

```bash
kubectl scale deployment web --replicas=3
kubectl get pods -o wide
```

### Step 6: Observe self-healing

Delete one pod and watch the Deployment's controller replace it to restore three replicas. Replace the pod name with one from your own output.

```bash
kubectl delete pod <one-of-your-pod-names>
kubectl get pods -w
```

### Step 7: Perform a rolling update

```bash
kubectl set image deployment/web nginx=nginx:1.27
kubectl rollout status deployment/web
```

### Step 8: Roll back the update

```bash
kubectl rollout undo deployment/web
kubectl rollout history deployment/web
```

### Step 9: Export the declarative form

Save the live Deployment as YAML. This is the same desired state expressed as code, which links this lab to the IaC principles of Week 2.

```bash
kubectl get deployment web -o yaml > web-deployment.yaml
```

### Step 10: Clean up

```bash
kubectl delete service web
kubectl delete deployment web
minikube stop
```

## 5. Your Tasks / Required Outcomes

- The exact sequence of `kubectl` commands you used, saved as a shell script or text file, and `web-deployment.yaml`.
- A dated terminal screenshot showing three running pods after scaling, the pod replaced after deletion, and the rollout history after the rollback.

---
⬅️ [Back to Lab Manual index](../README.md)
