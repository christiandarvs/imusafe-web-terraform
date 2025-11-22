# 🌐 ImuSafe Website EC2 Deployment (Terraform)

This Terraform configuration deploys a **static website** (from GitHub) to an AWS EC2 instance running **Nginx**. It automatically:

- Updates the server  
- Installs Nginx & Git  
- Clones the GitHub repo  
- Configures Nginx  
- Restricts access via IP-based Security Group  
- Tags resources properly  

---

## 🚀 Deployment Steps

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Preview the deployment
```bash
terraform plan
```

### 3. Deploy
```bash
terraform apply
```

---

## 🔍 What This EC2 Server Does

- Runs on Ubuntu  
- Installs Nginx and Git  
- Pulls the GitHub website repo  
- Serves static files via Nginx  
- Automatically enables + restarts Nginx  
- Only allows access from approved IPs  
