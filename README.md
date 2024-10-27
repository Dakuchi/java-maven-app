# CI/CD Pipeline with Deployment to EKS Cluster

This branch extends the CI/CD pipeline to deploy the application on an Amazon EKS cluster. The pipeline automates the build, versioning, image push, and deployment process using Kubernetes manifests for seamless deployment on EKS.

## Overview

This branch builds on previous CI/CD features, adding a deployment to Amazon EKS using Kubernetes configuration files stored in the `deploy-config` folder:
- **Deployment and Service YAML Files**: Located in `deploy-config`, these files are configured to dynamically adjust the application name and image name using Jenkins environment variables.
- **Docker Hub Secret**: Created on the EKS cluster to securely pull Docker images for deployment.

![deploy-on-eks](https://github.com/user-attachments/assets/4e73ac43-4da2-484a-9d62-23e163ad3647)

## Key Features

### 1. Kubernetes Deployment on EKS
The Jenkins pipeline deploys the application to EKS by:
- **Using Kubernetes Manifests**: `deployment.yaml` and `service.yaml` dynamically use the `APP_NAME` and `IMAGE_NAME` environment variables from Jenkins for the Kubernetes deployment.
- **Docker Hub Secret**: A Kubernetes Secret is configured on the EKS cluster to allow pulling Docker images securely.

### 2. Required Tools and Configuration in Jenkins
To connect and deploy to the EKS cluster, the following are required in Jenkins:
- **kubectl**: For Kubernetes command-line operations.
- **aws-iam-authenticator**: To authenticate Jenkins with AWS using IAM.
- **kubeconfig File**: Contains the connection configuration for the EKS cluster.
- **AWS Credentials**: AWS access credentials for Jenkins to interact with the EKS cluster.

## Pipeline Stages

1. **Version Increment**:
   - Automatically increments the version in `pom.xml` and sets the `IMAGE_NAME` environment variable for the Docker image. [See Version Increment Branch](https://github.com/Dakuchi/java-maven-app/tree/Version-increment).

2. **Build JAR**:
   - Builds the application JAR using Maven.

3. **Build and Push Docker Image**:
   - Builds and pushes the Docker image to Docker Hub with the new version tag.

4. **Deploy to EKS** (New in this Branch):
   - Uses Kubernetes manifests (`deployment.yaml` and `service.yaml`) in the `deploy-config` folder.
   - Deploys the Docker image to the EKS cluster, with `APP_NAME` and `IMAGE_NAME` dynamically replaced by environment variables.

5. **Commit Version Update**:
   - Commits the updated version to the Git repository to maintain version control.

## Prerequisites

### 1. AWS and Kubernetes Configuration
Ensure the following tools and configurations are set up in Jenkins:
- **AWS CLI**: AWS credentials (`jenkins_aws_access_key_id` and `jenkins_aws_secret_access_key`) configured in Jenkins for access to EKS.
- **kubectl and aws-iam-authenticator**: Installed in Jenkins to manage and authenticate with EKS.
- **kubeconfig File**: Configured to connect to the EKS cluster, stored in Jenkins for use in the pipeline.

### 2. Docker Hub Secret in EKS
Create a Kubernetes Secret on the EKS cluster to securely pull images from Docker Hub:
```bash
kubectl create secret docker-registry docker-hub-cred \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=<your-username> \
  --docker-password=<your-password> \
  --docker-email=<your-email>
