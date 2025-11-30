
# 🚀 AKS + NGINX Deployment 

## This project provisions an **Azure Kubernetes Service (AKS)** cluster using **Terraform only**, and automatically deploys an **NGINX web server** exposed through a public **LoadBalancer**.

It is designed to use the **absolute lowest-cost AKS configuration**, including:

* **1-node cluster**
* **Smallest supported VM size: `Standard_B2s`**
* Optional **Spot node** support
* No Azure CLI required

---

## 📦 What This Project Creates

Terraform deploys:

1. **Resource Group**
2. **AKS Cluster (Free tier control plane)**
3. **Single-node default pool (Standard_B2s)**
4. **NGINX Deployment (kubernetes_deployment)**
5. **Public LoadBalancer Service**
6. **Terraform output with the public IP for NGINX**

After apply, your NGINX instance is publicly accessible in the browser.

---

## 🛠 Requirements

* Terraform ≥ 1.5
* Azure subscription
* `az login` (only needed once to authenticate Terraform)

---

## ▶️ How to Deploy

1. Initialize Terraform:

```sh
terraform init
```

2. Review the plan:

```sh
terraform plan
```

3. Apply changes:

```sh
terraform apply
```

4. After provisioning completes, Terraform outputs the public IP:

```
nginx_public_ip = "20.xx.xx.xx"
```

Open that IP in your browser → you should see the **NGINX welcome page**.

---

## 💰 Optional: Ultra-Cheap Spot Node

To switch the AKS node pool to **Spot pricing**, add the following to the `default_node_pool` block in `main.tf`:

```hcl
priority        = "Spot"
eviction_policy = "Delete"
spot_max_price  = -1
```

Spot nodes can reduce AKS compute cost by **70–90%**, but may be evicted.

---

## 🧹 Cleanup

Destroy all resources to avoid ongoing charges:

```sh
terraform destroy
```

---

## 📘 Summary

This project demonstrates:

* A fully automated Terraform-only AKS deployment
* Provisioning workloads using the Terraform Kubernetes provider
* Using AKS on the **cheapest possible tier**
* Deploying and exposing container workloads without touching `kubectl`

