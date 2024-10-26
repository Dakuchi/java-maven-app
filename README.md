# Complete CI/CD Pipeline with Version Increment and EC2 Deployment

This **jenkins-pipeline** branch demonstrates a complete CI/CD pipeline that automates the build, version increment, Docker image creation, and deployment of a Java Maven application to an EC2 instance. The pipeline includes:
- Automated version incrementing and commit back to the repository
- Building and pushing a Docker image to Docker Hub
- Deploying the updated Docker container on an EC2 instance

![pipeline](https://github.com/user-attachments/assets/ebf702f6-c884-4893-929d-1d31e155f06e)

## Overview

The Jenkins pipeline in this branch integrates the features from previous branches:
- **Version Increment**: Automatically increments the application version in the `pom.xml` file.
- **Docker Build and Push**: Builds and pushes the Docker image with the new version tag to Docker Hub.
- **Deployment to EC2**: Deploys the Docker container to an EC2 instance using SSH and Docker Compose.

## Key Features

### 1. Version Incrementing
The pipeline automatically increments the `pom.xml` version whenever there is a code change, commits the updated version back to the Git repository, and uses it as part of the Docker image tag. For details on the version increment feature, see the [Version Increment Branch](https://github.com/Dakuchi/java-maven-app/tree/Version-increment).

### 2. Deployment to EC2 with SSH
The pipeline uses the `sshagent` Jenkins plugin to securely copy deployment files and execute the deployment script on an EC2 instance. This allows for automated deployment of the latest Docker image. For more information, refer to the [EC2 Deployment Branch](https://github.com/Dakuchi/java-maven-app/tree/feature/sshagent-terraform).

### 3. Shared Library Integration
This pipeline leverages functions from a Jenkins shared library to simplify the build, Docker image creation, and deployment steps. For more details on the shared library used in this pipeline, visit the [Shared Library Repository](https://github.com/Dakuchi/jenkins-shared-library).

## Configuration Details

### Requirements
- **GitHub Webhook**: A webhook should be configured in GitHub to trigger the pipeline on code changes.
- **SSH Credentials**: The Jenkins credentials should include the `github-sshkey` for GitHub commits and the `ec2-server-key` for SSH access to the EC2 instance.
- **Docker Hub Credentials**: Stored in Jenkins to authenticate and push images to Docker Hub.

## Pipeline Stages

1. **Version Increment**:
   - Increments the `pom.xml` version and sets it as part of the Docker image tag.
   - Commits the updated version back to the Git repository.

2. **Build JAR**:
   - Compiles and packages the application into a JAR file.

3. **Build and Push Docker Image**:
   - Builds the Docker image using the new version tag and pushes it to Docker Hub.

4. **Deploy to EC2**:
   - Copies deployment files (`docker-compose.yaml` and `server-cmds.sh`) to the EC2 instance and starts the updated Docker container using the new image.

5. **Commit Version Update**:
   - Commits the new version to GitHub in the `pom.xml` file to maintain version tracking in the repository.

## Usage

1. **Ensure GitHub and EC2 Configuration**:
   - Set up GitHub webhook and verify that the EC2 instance is accessible with the required SSH key.

2. **Run the Pipeline**:
   - The pipeline will automatically increment the version, build and push the Docker image, deploy to EC2, and commit the updated version to the repository.

3. **Verify Deployment**:
   - After deployment, check the EC2 instance to confirm the application is running with the latest Docker image.
