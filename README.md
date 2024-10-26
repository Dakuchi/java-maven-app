# Complete CI/CD Pipeline with EC2 Deployment

This branch extends the CI/CD pipeline by adding an automated deployment step to an AWS EC2 instance. The pipeline performs the following tasks:
- Builds the application
- Creates and pushes a Docker image
- Deploys the Docker container to an EC2 instance using SSH

![ssh agent](https://github.com/user-attachments/assets/066ccdac-af0e-4368-94cc-cd383e854b25)

## Overview

In this branch, the Jenkins pipeline is designed to:
1. **Build the Application**: Compiles and packages the Java Maven application.
2. **Build Docker Image and Push**: Creates a Docker image of the application and pushes it to Docker Hub.
3. **Deploy on EC2**: Copies deployment scripts and the Docker Compose file to an EC2 instance and runs the deployment command.

The deployment is managed using the `sshagent` Jenkins plugin to handle SSH connections securely to the EC2 instance.

## Key Features

### 1. Shared Library Integration
The pipeline uses a [Shared Library Repository](https://github.com/Dakuchi/jenkins-shared-library). that provides reusable functions such as `buildJar()`, `buildImage()`, `dockerLogin()`, and `dockerPush()`. These functions streamline the CI/CD process and centralize common tasks.

### 2. Deployment to EC2
- **EC2 Connection**: The `sshagent` plugin is used to manage SSH credentials, allowing Jenkins to securely connect to the EC2 instance and execute commands.
- **Docker Compose Deployment**: The pipeline copies `docker-compose.yaml` and a custom shell script, `server-cmds.sh`, to the EC2 instance to deploy the Docker container.
- **Deployment Script**: The `server-cmds.sh` script contains deployment commands that run the specified Docker image on the EC2 instance.

## Configuration Details

### 1. Jenkins Configuration

- **SSH Credentials**: Ensure that the `ec2-server-key` SSH key is stored in Jenkins credentials. This key is used by `sshagent` to connect to the EC2 instance.
- **Docker Hub Credentials**: Docker credentials are required for logging into Docker Hub to push the Docker image.

### 2. Jenkinsfile Overview

The Jenkinsfile in this branch includes the following key stages (code already exists in the repository):
- **Build App**: Uses the `buildJar()` function to compile and package the application.
- **Build and Push Docker Image**: Calls `buildImage()`, `dockerLogin()`, and `dockerPush()` to create the Docker image and push it to Docker Hub.
- **Deploy to EC2**:
   - Copies `docker-compose.yaml` and `server-cmds.sh` to the EC2 instance.
   - Executes `server-cmds.sh` remotely to deploy the Docker container.

### 3. EC2 Deployment Steps

1. **Copy Deployment Files**:
   - `docker-compose.yaml` and `server-cmds.sh` are copied to the `/home/ec2-user` directory on the EC2 instance.
   
2. **Run Deployment Script**:
   - The `server-cmds.sh` script on the EC2 instance uses Docker Compose to start the container with the updated application version.

## Usage

1. **Ensure EC2 and Jenkins Configuration**:
   - Verify that the EC2 instance is accessible, and SSH credentials (`ec2-server-key`) are set up in Jenkins.

2. **Run the Pipeline**:
   - The pipeline stages will build and push the Docker image, then securely connect to the EC2 instance to deploy the application.

3. **Verify Deployment**:
   - Check the EC2 instance to ensure the Docker container is running with the latest application version.
