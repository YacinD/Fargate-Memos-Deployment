# Fargate Memos Deployment

A containerised deployment of **Memos on AWS ECS Fargate**, with infrastructure managed using **Terraform** and deployments automated through **GitHub Actions**.

This project demonstrates practical DevOps concepts including Docker, AWS networking, Infrastructure as Code, CI/CD, HTTPS and secure AWS authentication.

## 🎥 Live Deployment

<!-- LIVE WEBSITE VIDEO GOES HERE -->

**Live application:**
https://ecsv1.online

*Add deployment walkthrough video here showing the live website running.*

## 🏗️ Architecture

<!-- ARCHITECTURE DIAGRAM GOES HERE -->

![Architecture Diagram](./docs/architecture.png)

The application follows:

**User → Route 53 → ALB → ECS Fargate → Memos**

* **Route 53** - Routes the custom domain to the application.
* **ALB** - Handles HTTPS traffic and forwards requests to ECS.
* **ECS Fargate** - Runs the container without managing servers.
* **ECR** - Stores the Docker image used by ECS.
* **VPC** - Provides isolated AWS networking.

## 📁 Project Structure

<!-- PROJECT STRUCTURE SVG GOES HERE -->

*Add the project structure SVG/tree diagram here.*

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

**SVG:** *Project structure diagram to be added here.*

## 🛠️ Tech Stack

* **AWS:** ECS Fargate, ECR, ALB, VPC, Route 53, ACM, IAM
* **Infrastructure:** Terraform
* **Containerisation:** Docker
* **CI/CD:** GitHub Actions
* **Authentication:** GitHub OIDC
* **Application:** Memos / Go

## 🏗️ Infrastructure

Terraform manages the AWS infrastructure, including the VPC, subnets, NAT Gateway, route tables, security groups, ECR, ECS, ALB, ACM and Route 53.

Using Terraform makes the infrastructure **reproducible, version-controlled and easier to maintain** rather than relying on manual AWS configuration.

## 🔄 CI/CD

GitHub Actions automates the deployment process:

**Git Push → Docker Build → ECR → Terraform → ECS → Health Check**

The workflow uses **GitHub OIDC** to authenticate with AWS, avoiding long-lived AWS access keys.

After deployment, an automated health check verifies that the live application returns **HTTP 200**.

## 🔐 Security

* ECS runs within the VPC
* Security groups restrict application traffic
* HTTPS is enabled through ACM
* IAM controls AWS permissions
* GitHub OIDC removes the need for long-lived AWS credentials

## 📚 What I Learned

This project followed a **ClickOps → Terraform → CI/CD** approach, giving hands-on experience with deploying, troubleshooting and automating a real AWS workload.

Key areas covered:

**Docker • AWS Networking • ECS Fargate • ECR • Terraform • CI/CD • IAM • OIDC • HTTPS • DNS**

