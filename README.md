# Java Maven App Deployment with Jenkins CI/CD Pipeline

This project demonstrates a simple Java Maven app integrated with a Jenkins CI/CD pipeline. The goal is to showcase automated workflows that incorporate infrastructure provisioning, deployment, and version control using various DevOps tools like Jenkins, Ansible, Terraform, and Kubernetes.

## Project Structure

The project consists of several branches, each focusing on different aspects of the CI/CD process.

### Main Branch

The `main` branch contains the core structure of the project:
- **src/**: Source code of the Java Maven app.
- **Dockerfile**: Used to build the application into a Docker image.
- **Jenkinsfile**: Defines the pipeline stages for building, testing, and deploying the app.
- **pom.xml**: Maven configuration file for building the project.
- **script.groovy**: Script used within the Jenkins pipeline.

## Feature Branches

### `feature/ansible`
Integrates **Ansible** to install software on a remote server as part of the Jenkins pipeline. This branch demonstrates how Jenkins can interact with remote environments via Ansible for automated provisioning.

### `feature/sshagent-terraform`
Adds a **Terraform** stage to provision an EC2 instance within the Jenkinsfile. This stage sets up the necessary infrastructure for deploying the app on AWS.

### `feature/jenkinsfile-sshagent`
This branch adds an **sshagent** step in the Jenkinsfile, which allows Jenkins to securely copy scripts to the EC2 instance and execute them remotely.

### `feature/deploy-on-k8s`
Includes **Kubernetes deployment** in the Jenkinsfile, showcasing how the application can be deployed in a Kubernetes cluster as part of the CI/CD pipeline.

### `jenkins-pipeline`
A basic Jenkins pipeline job that covers the following stages:
1. **Build Image**: Builds the Docker image for the Java Maven app.
2. **Deploy Image**: Deploys the Docker image on an EC2 instance.
3. **Push to Registry**: Pushes the created image to **Docker Hub** or **ECR**.
4. **Pull Image to Deployment Server**: Pulls the image from Docker Hub or ECR to the deployment server.
5. **Commit Version**: Commits the new version to the Git repository.

### `Version-increment`
This branch focuses on automatically updating the **minor version** in the `pom.xml` file whenever changes are detected in the Git repository. Jenkins manages this process through a version-incrementing pipeline.

### `jenkins-shared-lib`
This branch uses a **Jenkins shared library** to build the Java Maven app. It demonstrates the reusability of pipeline code using shared libraries.

### `jenkins-jobs`
Builds Docker images using a Groovy script for a **multi-branch Jenkins job**. This branch highlights how different branches in a repository can trigger independent Jenkins jobs.

## Technologies Used
- **Jenkins**: Automates the CI/CD pipeline.
- **Java & Maven**: For building the application.
- **Docker**: Containerization of the application.
- **Ansible**: For automation and provisioning.
- **Terraform**: Infrastructure provisioning on AWS.
- **Kubernetes**: Container orchestration.
- **Groovy**: Scripting in Jenkins for pipeline automation.
- **AWS**: Cloud infrastructure provider.
- **Docker Hub / ECR**: For storing Docker images.

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/Dakuchi/java-maven-app.git
