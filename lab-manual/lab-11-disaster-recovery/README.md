# Lab 11: Disaster Recovery Automation

|  |  |
|---|---|
| **Week** | 13 |
| **Mapped CLO** | CLO-3 (Evaluate) |
| **Tools / Environment** | Velero; MinIO; Restic; Minikube; kubectl |
| **Estimated Time** | 150 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain the role of automated backup and restore in infrastructure reliability.
- Configure Velero to back up and restore Kubernetes resources to an S3-compatible store.
- Back up and restore files with Restic and compare the two tools.
- Evaluate recovery time and completeness after a simulated disaster.

## 2. Preamble / Short Theory

Velero (open source, CNCF) backs up Kubernetes resources and, optionally, volume contents. For volume contents its file-system backup uses Kopia; the older Restic path was deprecated and removed from Velero's backup path in recent releases, so this lab uses Restic separately and as a standalone tool to show the underlying concept of encrypted, deduplicated snapshots.

A local MinIO server stands in for the S3 object store that Velero needs, so no cloud account is required. Because Velero runs inside the Minikube cluster, it reaches MinIO on your computer through the special name `host.minikube.internal`, not `127.0.0.1` (which would point back at the Velero pod itself).

## 3. Prerequisites

- Lab 5 completed (Minikube cluster available).
- Docker installed (to run MinIO).
- Restic installed (`sudo apt install restic` or `brew install restic`).

## 4. Step-by-Step Guide

### Step 1: Start MinIO and create the bucket

```bash
docker run -d --name minio -p 9000:9000 -p 9001:9001 \
  -e "MINIO_ROOT_USER=minio" -e "MINIO_ROOT_PASSWORD=minio12345" \
  minio/minio server /data --console-address ":9001"
```

Open http://127.0.0.1:9001, log in with `minio` / `minio12345`, and create a bucket named `velero-backups`.

### Step 2: Start the cluster and install the Velero CLI

Run `minikube start --driver=docker`. Download the latest release for your operating system from github.com/vmware-tanzu/velero/releases and add it to your PATH. Then check the compatibility table in the `velero-plugin-for-aws` README to find the plugin tag that matches your CLI version.

### Step 3: Create the credentials file

Save as `credentials-velero` (a lab-only secret; never commit it).

📄 **File:** `credentials-velero.example`

```text
[default]
aws_access_key_id = minio
aws_secret_access_key = minio12345
```

> 💾 Saved in this folder: [`credentials-velero.example`](credentials-velero.example)

### Step 4: Install Velero into the cluster

```bash
export AWS_PLUGIN_VERSION=vX.Y.Z   # pick the tag listed as compatible with your Velero CLI

velero install \
  --provider aws \
  --plugins velero/velero-plugin-for-aws:$AWS_PLUGIN_VERSION \
  --bucket velero-backups \
  --secret-file ./credentials-velero \
  --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://host.minikube.internal:9000 \
  --use-volume-snapshots=false \
  --use-node-agent \
  --default-volumes-to-fs-backup

velero backup-location get     # the PHASE column must read Available
```

### Step 5: Deploy something to back up

```bash
kubectl create deployment demo --image=nginx:stable
kubectl expose deployment demo --port=80
kubectl create configmap demo-config --from-literal=owner="Your Name - Roll No"
kubectl get deployments,services,configmaps
```

### Step 6: Create a backup

```bash
velero backup create demo-backup --include-namespaces default
velero backup describe demo-backup
velero backup get
```

### Step 7: Simulate a disaster

```bash
kubectl delete deployment demo
kubectl delete service demo
kubectl delete configmap demo-config
kubectl get deployments,services,configmaps
```

### Step 8: Restore and time the recovery

```bash
time velero restore create demo-restore --from-backup demo-backup --wait
kubectl get deployments,services,configmaps
velero restore describe demo-restore
```

### Step 9: Practice with Restic

Repeat the idea at file level: back up a folder, destroy it, and restore it from the encrypted repository. Note that Restic restores the original full path beneath the target folder.

```bash
mkdir -p ~/lab11-data && echo "important record" > ~/lab11-data/file.txt
export RESTIC_PASSWORD='lab-only-password'      # lab use only; never commit a real one
restic init -r ~/lab11-restic-repo
restic -r ~/lab11-restic-repo backup ~/lab11-data
rm -rf ~/lab11-data                              # simulated disaster
restic -r ~/lab11-restic-repo snapshots
restic -r ~/lab11-restic-repo restore latest --target ~/lab11-restored
find ~/lab11-restored -name file.txt -exec cat {} \;
```

### Step 10: Evaluate recovery

Record how long the restore took and verify that every resource returned. Write a short evaluation (maximum one page) of what this strategy would and would not protect against (for example, corrupted data replicated into the backup, loss of the backup store itself, or a region-wide outage) and what additional automation would mitigate those gaps.

## 5. Your Tasks / Required Outcomes

- The exact `velero`, `kubectl`, and `restic` command sequence used.
- A dated screenshot showing the backup, the simulated deletion, and the successful restore.
- The written evaluation (maximum one page) on recovery completeness and remaining risk.

## 📁 Files in this folder

- [`credentials-velero.example`](credentials-velero.example)

---
⬅️ [Back to Lab Manual index](../README.md)
