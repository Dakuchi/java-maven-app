# Multibranch Jenkins Job for Main Branch

This document outlines the setup and testing process for a multibranch Jenkins job that demonstrates the build and deploy pipeline stages for the `main` branch of this project. The pipeline uses a Groovy script to:

- **Build the Application JAR**
- **Build a Docker Image**
- **Push the Docker Image to Docker Hub**

## Overview

The multibranch Jenkins job is configured to automatically detect branches in the repository and trigger builds based on the Jenkinsfile for each branch. In this case, the `main` branch demonstrates:

- **Build Stage**: Uses Maven to build the application JAR.
- **Docker Build Stage**: Creates and pushes a Docker image to Docker Hub.
- **Deploy Stage**: Placeholder stage for deploying the application.

The pipeline is implemented using a **Groovy script** within the Jenkinsfile, providing flexibility and customization for the build and deployment process.

## Pre-requisites

- A running Jenkins server with the necessary plugins (Git, Docker, Pipeline) installed.
- **Maven plugin** installed in Jenkins to handle the Maven build process.
- Docker credentials configured in Jenkins (`docker-hub-repo`).
- Jenkins set up using Docker Compose or manually.
- Access to Docker for building and pushing the image.
- Docker permissions set within the Jenkins container to allow execution of Docker commands.

For instructions on how to set up the Jenkins server using Docker Compose, refer to the [Jenkins Server Setup Guide](https://github.com/Dakuchi/java-maven-app/tree/jenkins-server-setup#jenkins-server-setup-with-docker-compose).

## Steps to Configure and Run the Multibranch Pipeline Job

### 1. Install the Maven Plugin in Jenkins

Before setting up the multibranch job, ensure the Maven plugin is installed:

1. In Jenkins, go to **Manage Jenkins** > **Manage Plugins**.
2. Search for the **Maven Integration Plugin** in the **Available** tab.
3. Install the plugin and restart Jenkins if necessary.

### 2. Create a New Multibranch Pipeline in Jenkins

1. In Jenkins, click on **New Item**.
2. Select **Multibranch Pipeline** and give the job a name (e.g., `Multibranch-JavaApp`).
3. Click **OK**.

### 3. Configure the Multibranch Pipeline

1. In the **Branch Sources** section, click **Add Source** and select **Git**.
2. In the **Repository URL** field, enter the URL of your Git repository: https://github.com/Dakuchi/java-maven-app.git
3. Leave the **Credentials** field empty (or set credentials if your repository is private).
4. In the **Discover Branches** behavior, ensure Jenkins is configured to detect all branches.
5. Save the configuration.

### 4. Permissions for Docker Execution

To ensure Jenkins can run Docker commands inside the Jenkins container, we need to adjust the permissions of the Docker socket:

1. Open a shell session in the running Jenkins container with root privilege:

```bash
docker exec -u 0 -it jenkins bash
chmod 666 /var/run/docker.sock
```
