# Fargate Memos Deployment

A production-style deployment of the **Memos application on AWS ECS Fargate**, provisioned with **Terraform** and automated through **GitHub Actions**.

The project demonstrates the full DevOps workflow - containerisation, AWS infrastructure, Infrastructure as Code, CI/CD, HTTPS, custom DNS, secure authentication and post-deployment health checks.

## 🚀 Project Overview

* **Application:** Memos
* **Cloud:** AWS
* **Compute:** ECS Fargate
* **Container Registry:** Amazon ECR
* **Infrastructure:** Terraform
* **CI/CD:** GitHub Actions
* **Load Balancer:** Application Load Balancer
* **HTTPS:** AWS Certificate Manager
* **DNS:** Route 53
* **Authentication:** GitHub Actions OIDC
* **Region:** `eu-west-2`
* **Status:** Live

🌐 **Live Application:** https://ecsv1.online

## 🏗️ Architecture

The application runs as a containerised workload on **AWS ECS Fargate**.

Traffic reaches the application through a custom domain and HTTPS-enabled Application Load Balancer. The ALB forwards traffic to the ECS Fargate service running the Memos container on port `5230`.

The infrastructure is deployed within a custom VPC using public and private networking, security groups, route tables and a NAT Gateway.

### Traffic Flow

**User → Route 53 → ALB → ECS Fargate → Memos**

## 🛠️ Technologies

| Technology                | Purpose                        |
| ------------------------- | ------------------------------ |
| AWS ECS Fargate           | Container compute              |
| Amazon ECR                | Docker image storage           |
| Application Load Balancer | Traffic routing & HTTPS        |
| VPC                       | Network isolation              |
| NAT Gateway               | Private subnet outbound access |
| Route 53                  | DNS                            |
| ACM                       | TLS certificate                |
| Terraform                 | Infrastructure as Code         |
| Docker                    | Containerisation               |
| GitHub Actions            | CI/CD                          |
| GitHub OIDC               | Secure AWS authentication      |
| Go                        | Application backend            |
| SQLite                    | Application database           |

## 📁 Project Structure

```text
Fargate-Memos-Deployment/
├── app/
│   ├── Dockerfile
│   └── README.md
│
├── infra/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── backend.tf
│   └── ...
│
├── .github/
│   └── workflows/
│       ├── build.yml
│       └── deploy.yml
│
└── README.md
```

## 🐳 Docker

The Memos application is containerised using a **multi-stage Docker build**.

The build separates the frontend, backend and runtime stages, keeping the final production image focused on the application runtime.

The container exposes:

```text
5230
```

The image is built and pushed to **Amazon ECR** as part of the deployment workflow.

## ☁️ AWS Infrastructure

Terraform provisions the AWS infrastructure required to run the application.

Key resources include:

* VPC
* Public and private subnets
* Internet Gateway
* NAT Gateway
* Route tables
* Route table associations
* Network ACLs
* Security groups
* ECR repository
* ECS cluster
* ECS task definition
* ECS service
* Application Load Balancer
* Target group
* ALB listeners
* ACM certificate
* Route 53 records
* IAM resources

The ECS tasks run behind the ALB while networking and security controls restrict direct access to the application.

## 🏗️ Infrastructure as Code

The AWS environment is managed using **Terraform** rather than relying on manual configuration.

Terraform provides:

* Reproducible infrastructure
* Version-controlled configuration
* Consistent deployments
* Infrastructure change tracking
* Automated planning and deployment

Terraform state is managed remotely to maintain a consistent source of truth for the deployed infrastructure.

## 🔄 CI/CD

GitHub Actions automates the deployment process.

The pipeline performs:

1. Checkout source code
2. Authenticate to AWS using OIDC
3. Build the Docker image
4. Push the image to ECR
5. Initialise Terraform
6. Validate the configuration
7. Generate a Terraform plan
8. Apply the infrastructure
9. Wait for the service to stabilise
10. Perform a post-deployment health check

### AWS Authentication

The workflow uses **GitHub Actions OIDC** to assume an AWS IAM role.

This avoids storing long-lived AWS access keys inside GitHub.

## 🔐 Security

Security was considered throughout the deployment.

* ECS tasks run within the VPC
* Security groups control traffic between the ALB and ECS
* HTTPS encrypts client traffic
* ACM manages the TLS certificate
* IAM controls AWS permissions
* GitHub OIDC removes the need for long-lived AWS credentials
* ECR provides private container image storage
* Private networking is used for ECS workloads

## 🌐 HTTPS & Custom Domain

The application is available through a custom domain:

**https://ecsv1.online**

HTTPS is terminated at the Application Load Balancer using an AWS Certificate Manager certificate.

Route 53 manages DNS resolution for the domain.

## ❤️ Health Checks

The CI/CD pipeline performs an automated post-deployment health check.

After Terraform completes, the workflow waits for the service to stabilise and sends an HTTP request to the live application.

The deployment is considered successful when:

```text
HTTP 200
```

is returned.

If the application fails the health check, the GitHub Actions workflow fails.

## 📚 What This Project Demonstrates

This project provides hands-on experience with:

* AWS cloud infrastructure
* Docker containerisation
* ECS Fargate
* Amazon ECR
* VPC networking
* Application Load Balancers
* HTTPS/TLS
* Route 53
* IAM
* Terraform
* Remote Terraform state
* GitHub Actions
* CI/CD
* GitHub OIDC
* Infrastructure troubleshooting
* Automated deployment validation

## 🎯 Key Learning

The project follows a **ClickOps → Terraform → CI/CD** progression.

Infrastructure was first understood and configured manually before being translated into Terraform and eventually automated through GitHub Actions.

This provided practical experience understanding not only **how to deploy an application**, but also how the underlying AWS networking, security, infrastructure and automation work together.

## 📊 Project Status

| Component           | Status     |
| ------------------- | ---------- |
| Docker              | ✅ Complete |
| ECR                 | ✅ Complete |
| ECS Fargate         | ✅ Complete |
| VPC & Networking    | ✅ Complete |
| ALB                 | ✅ Complete |
| HTTPS / ACM         | ✅ Complete |
| Custom Domain       | ✅ Complete |
| Terraform           | ✅ Complete |
| GitHub Actions      | ✅ Complete |
| OIDC Authentication | ✅ Complete |
| Health Check        | ✅ Complete |
| Live Deployment     | ✅ Live     |

---

**Built as a hands-on DevOps project to demonstrate AWS, Terraform, Docker and CI/CD in a complete cloud deployment.**
