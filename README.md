# Version Increment Branch

This branch demonstrates an automated process for incrementing the version in the `pom.xml` file whenever code changes are pushed to the repository. The updated version is then committed back to the repository.

![Uploading version increase.png…]()


## Overview

The version increment process works as follows:
- **Version Increment**: The version in the `pom.xml` file is incremented using the Maven `build-helper` and `versions` plugins.
- **Build Process**: The project is built using Maven, and a Docker
mage is created with the incremented version in the tag.
- **Commit and Push**: The updated `pom.xml` file is committed and pushed back to the repository.

## Key Features

### 1. Version Increment
- The version in the `pom.xml` file is incremented automatically when changes are detected in the repository. The version is set as `majorVersion.minorVersion.nextIncrementalVersion`.

### 2. Jenkins Pipeline
- The Jenkins pipeline in this branch handles the version increment, builds the application, creates a Docker image, and commits the updated version back to the repository.
- **Avoiding Loop Jobs**: The Jenkins pipeline is configured to avoid triggering a loop by ignoring Git changes made by the Jenkins user itself.

### 3. GitHub Trigger and Jenkins Webhook
- **GitHub Trigger**: The pipeline is triggered by code changes in the repository using GitHub triggers.
- **Jenkins Webhook**: A webhook is set up between GitHub and Jenkins to notify Jenkins of changes. The pipeline will only trigger for changes made by developers, avoiding an infinite loop by skipping changes made by the Jenkins user.

## Configuration Details

### GitHub and Jenkins Integration
1. **GitHub Trigger**: Ensure the repository has a webhook set up to notify Jenkins of changes. The trigger initiates the version increment process when code is pushed to the repository.
   
2. **Avoiding Loop Jobs**: The pipeline is designed to ignore Git changes made by Jenkins itself (e.g., when the updated `pom.xml` is committed and pushed by Jenkins). This prevents the pipeline from running in an endless loop.

### Version Increment Process
- The `pom.xml` version is incremented using the `build-helper:parse-version` and `versions:set` Maven commands.
- After updating the version, the Jenkins pipeline builds the application and creates a Docker image with the new version tag.

### Commit and Push
- After the Docker image is built and pushed to Docker Hub, Jenkins commits the updated `pom.xml` back to the repository.
- The pipeline uses SSH credentials to push the changes to the `Version-increment` branch.

## Usage

1. **Ensure GitHub Webhook is Configured**:
   - Set up a webhook in your GitHub repository to trigger the Jenkins pipeline when code changes are pushed.

2. **Ensure SSH Credentials are Configured**:
   - SSH credentials should be configured in Jenkins to allow the pipeline to push changes back to the GitHub repository using `git`.

3. **Running the Pipeline**:
   - The pipeline automatically increments the version in the `pom.xml`, builds the application, creates a Docker image, and commits the updated version back to the repository.

4. **Avoiding Infinite Trigger Loops**:
   - The pipeline is designed to skip triggering itself when Jenkins pushes the updated `pom.xml` file back to the repository, preventing an infinite loop.
