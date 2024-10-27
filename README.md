# CI/CD Pipeline with ECR Integration for EKS Deployment

This branch extends the [CI/CD pipeline with EKS deployment](https://github.com/Dakuchi/java-maven-app/tree/feature/deploy-on-k8s) by pushing the Docker image to Amazon Elastic Container Registry (ECR) instead of DockerHub and deploying the application on an Amazon EKS cluster. With this update, the pipeline:
- Builds and pushes the Docker image to ECR
- Deploys the application to EKS using Kubernetes manifests

![deploy-on-eks-ecr](https://github.com/user-attachments/assets/5e39473a-9a90-4dde-92d4-8a10e02d5366)

## Overview

This branch builds on previous EKS deployment functionality, adding AWS ECR as the Docker image repository. The Jenkins pipeline stages include:
- **Version Increment**: Automatically increments the version in `pom.xml`.
- **Build and Push to ECR**: Builds the Docker image and pushes it to the ECR repository.
- **Deploy to EKS**: Uses Kubernetes manifests from the `deploy-config` folder to deploy the updated image to EKS.

## Requirements

To support ECR integration, additional credentials and setup are required in Jenkins and the EKS cluster.

### 1. Jenkins Requirements

- **ECR Credentials**: Configure Jenkins with ECR login credentials using `usernamePassword` to authenticate and push Docker images.
- **AWS CLI and ECR Access**: Ensure Jenkins has `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` credentials configured for access to ECR.

### 2. EKS Cluster Requirements

- **EKS Secret for ECR Access**: A Kubernetes Secret must be created on the EKS cluster to allow pulling images from ECR:
   ```bash
   kubectl create secret docker-registry ecr-cred \
     --docker-server=<your-aws-eks-server> \
     --docker-username=<AWS_ACCESS_KEY_ID> \
     --docker-password=<AWS_SECRET_ACCESS_KEY> \
     --docker-email=<your-email@example.com>

### For more information on EKS deployment pipeline stages, refer to the [CI/CD pipeline with EKS deployment](https://github.com/Dakuchi/java-maven-app/tree/feature/deploy-on-k8s) branch
