# Multibranch Jenkins Job for Main Branch

This document outlines the setup and testing process for a multibranch Jenkins job that demonstrates the pipeline stages for the `main` branch of this project. In this demonstration, the actual build and deploy functions are represented by placeholder commands (`echo "building image"` and `echo "deploying app"`).

## Overview

The multibranch Jenkins job is configured to automatically detect branches in the repository and trigger builds based on the Jenkinsfile for each branch. In this case, the `main` branch will demonstrate:
- **Build Stage**: A placeholder that simulates building the application.
- **Deploy Stage**: A placeholder that simulates deploying the application.

## Pre-requisites

- A running Jenkins server with the necessary plugins (Git, Pipeline) installed.
- Jenkins set up using Docker Compose or manually.
- The repository configured with a Jenkinsfile for the `main` branch.

For instructions on how to set up the Jenkins server using Docker Compose, refer to the [Jenkins Server Setup Guide](https://github.com/Dakuchi/java-maven-app/tree/jenkins-server-setup#jenkins-server-setup-with-docker-compose).

## Steps to Configure and Run the Multibranch Pipeline Job

### 1. Create a New Multibranch Pipeline in Jenkins

1. In Jenkins, click on **New Item**.
2. Select **Multibranch Pipeline** and give the job a name (e.g., `Multibranch-JavaApp`).
3. Click **OK**.

### 2. Configure the Multibranch Pipeline

1. In the **Branch Sources** section, click **Add Source** and select **Git**.
2. In the **Repository URL** field, enter the URL of your Git repository: https://github.com/Dakuchi/java-maven-app.git
3. Leave the **Credentials** field empty (or set credentials if your repository is private).
4. In the **Discover Branches** behavior, ensure Jenkins is configured to detect all branches.
5. Save the configuration.

### 3. Running the Multibranch Pipeline

Once configured, Jenkins will automatically scan the repository for branches and create jobs for each one. However, in this case, we are focused on the `main` branch.

1. Jenkins should detect the `main` branch and create a job for it.
2. The job will run the pipeline defined in the Jenkinsfile for the `main` branch.
3. The build progress will be show and logs in Jenkins, which will display:
- `echo "Building image"` in the build stage.
- `echo "Deploying app"` in the deploy stage.


