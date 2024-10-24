# Jenkins Pipeline Using Shared Library

This branch demonstrates how to integrate a Jenkins shared library in a Jenkins pipeline to automate the build and deployment of a Java Maven application with Docker. The Jenkinsfile in this branch utilizes reusable functions from the shared library to streamline the CI/CD process.

## Overview

The Jenkinsfile leverages the following functions from the shared library:
- **buildJar()**: Compiles the Java application into a JAR file using Maven.
- **buildImage()**: Builds a Docker image from the application.
- **dockerLogin()**: Logs into Docker Hub using credentials stored in Jenkins.
- **dockerPush()**: Pushes the Docker image to Docker Hub.

These functions are defined in the shared library and are used within the Jenkins pipeline to automate key stages of the CI/CD process.

## Shared Library Integration

The shared library is retrieved from a GitHub repository and provides the reusable pipeline functions. For more information on the shared library and how it works, visit the repository here:

[Shared Library Repository](https://github.com/Dakuchi/jenkins-shared-library)

## Jenkins Pipeline Configuration

- **Shared Library**: The Jenkinsfile in this branch imports the shared library using the `library` block. Jenkins automatically retrieves the library from the specified repository and branch.
- **Docker Hub Credentials**: Docker credentials are stored in Jenkins and used in the pipeline to log into Docker Hub and push the image.

## Usage

1. **Ensure Jenkins is Configured**:
   - The shared library repository is accessible to Jenkins.
   - Docker credentials are set up in Jenkins as `usernamePassword` credentials.
  
2. **Running the Pipeline**:
   - The pipeline stages will build the JAR, create a Docker image, log into Docker Hub, and push the image.

3. **Customization**:
   - Modify the Docker image name, tag, or credentials as needed for your project.

## Conclusion

This branch demonstrates how to use a Jenkins shared library to automate CI/CD pipeline stages for building and deploying a Java application with Docker. By using the shared library, the pipeline code remains modular and reusable, simplifying the management of Jenkins pipelines.

For more details on the shared functions, visit the [Shared Library Repository](https://github.com/Dakuchi/jenkins-shared-library).
