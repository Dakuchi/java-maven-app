# Jenkins Server Setup with Docker Compose

This document provides detailed steps to set up a Jenkins server using Docker and Docker Compose. It also includes manual steps for interacting with the Jenkins container, such as retrieving the admin password for the initial setup.

## Prerequisites

- **Docker**: Make sure Docker is installed and running on your system.
- **Docker Compose**: Ensure Docker Compose is installed.

## Steps to Provision Jenkins Server

### 1. Clone the Repository
####
    git clone https://github.com/Dakuchi/java-maven-app.git
   
### 2. Navigate to jenkins server setup directory
####
    cd java-maven-app/jenkins-server-setup

### 3. Run the docker-compose
####
    docker-compose up -d
   
### 4. Retrieve Initial Admin Password
####
    docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   
### 5. Access Jenkins using intial admin password
####
    http://localhost:8080

### 6. Install Jenkins Plugins
#### Install suggested plugins for a quick setup
