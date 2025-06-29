
# QR Code App – Full DevOps Deployment on AWS

This document describes the full end-to-end DevOps process for deploying a fullstack QR code generator app to AWS using Terraform, Docker, and GitHub Actions.

---

## 🏛️ Project Overview

The QR app is a simple fullstack application with a Flask backend and a basic HTML/JS frontend. The backend generates QR codes from input text, and the frontend allows users to submit the text and display the result.

The goal of this project is to implement a production-grade DevOps pipeline including:

- Infrastructure as Code (Terraform)
- Containerization (Docker)
- CI/CD (GitHub Actions)
- Hosting on AWS EC2, ALB, ECR, Route53, ACM
- Domain setup and HTTPS

---

## 📂 Project Structure

```
qr-app-project/
│
├── backend/                # Flask app with QR code generation
├── frontend/               # Simple HTML/JS frontend
├── terraform/
│   ├── environments/
│   │   └── dev/           # Environment-specific Terraform config
│   └── modules/           # Reusable modules: vpc, ec2, alb, ecr, sg, route53
├── .github/
│   └── workflows/         # GitHub Actions CI/CD pipeline
```

---

## ⚙️ Technologies Used

| Tool              | Purpose                       |
|-------------------|-------------------------------|
| Terraform         | Infrastructure as Code        |
| Docker            | Containerization              |
| Docker Compose    | Local service management      |
| AWS EC2           | App hosting                   |
| AWS ECR           | Docker image repository       |
| AWS ALB           | Load balancer & routing       |
| AWS ACM           | TLS/SSL (HTTPS)               |
| AWS Route53       | DNS & domain management       |
| GitHub Actions    | CI/CD pipeline                |

---

## 📅 Step-by-Step Implementation

### 1. Dockerization
- Wrote separate `Dockerfile` for frontend and backend
- Defined `docker-compose.yml` for running both services locally

### 2. Terraform Infrastructure
- Modules for:
  - VPC, subnets, Internet Gateway
  - EC2 instance for running the app
  - ALB with host-based routing rules
  - ECR repositories for frontend/backend
  - Route53 hosted zone & DNS records
  - Security groups with least access
- Remote backend using S3 and DynamoDB

### 3. Domain Setup
- Domain purchased from Hostinger: `mehran.app`
- Nameservers updated to point to Route53
- Records:
  - `dev.mehran.app` for frontend
  - `api.dev.mehran.app` for backend

### 4. HTTPS with ACM
- TLS certificate created in AWS ACM
- ALB listeners configured for HTTPS (443)
- HTTP (80) redirected to HTTPS

### 5. CI/CD Pipeline with GitHub Actions

#### Job 1: Build & Push to ECR
- On push to `master`
- Build Docker images (frontend, backend)
- Push to Amazon ECR with `latest` and commit SHA tags

#### Job 2: Deploy to EC2
- SSH into EC2 using private key stored as GitHub Secret
- Navigate to deployment directory
- Pull latest images from ECR
- Restart services using Docker Compose

---

## 📚 Key Commands

### Terraform
```bash
cd terraform/environments/dev
terraform init
terraform apply
```

### Local Docker Compose
```bash
docker compose up --build
```

---

## 🌐 Live URLs

| Component | URL                          |
|-----------|------------------------------|
| Frontend  | https://dev.mehran.app       |
| Backend   | https://api.dev.mehran.app   |
| Health    | https://api.dev.mehran.app/health |

---

## 🔒 Security Measures

- IAM user used in CI with limited permissions (only ECR access)
- SSH private key used only via GitHub Secrets
- Security groups limited to necessary ports (22, 80, 443)
- HTTPS enforced via ALB + ACM
- Remote Terraform state with locking via DynamoDB

---

## 🔄 Future Improvements

| Feature               | Benefit                       |
|-----------------------|-------------------------------|
| Centralized logging (CloudWatch) | Debugging & observability        |
| Blue/Green Deployments          | Zero downtime releases           |
| Auto Rollbacks                  | Safer CI/CD                      |
| Alerting (Slack, Email)         | Faster response to failures      |

---

