# CI/CD Pipeline with Automated EC2 Provisioning Using Terraform

## Overview

This branch extends the CI/CD pipeline by provisioning an EC2 instance and configuring its network resources using Terraform, then deploying the application on the instance. The key features added in this branch include:
- Automated VPC, subnet, internet gateway, and security group creation
- Storing the Terraform state in an S3 bucket for collaboration
- Setting up the EC2 instance with Docker and Docker Compose for deployment

![pipeline terraform](https://github.com/user-attachments/assets/3e4e1e91-30ad-4416-a116-801f5a8eb59f)

The Terraform configuration is managed within the `terraform` folder and includes files like `main.tf`, `variables.tf`, and `entry_script.sh`.

## Key Features

### 1. Infrastructure Provisioning with Terraform
The pipeline’s **Provision Server** stage uses Terraform `main.tf` configuration file and input variable `variables.tf`in the `terraform` folder to automatically set up the necessary AWS resources, including:
- **VPC and Subnet**: Creates a custom VPC and subnet to isolate the infrastructure.
- **Internet Gateway and Route Table**: Configures network routing to enable internet access.
- **Security Group**: Restricts access to the EC2 instance for secure connections from specific IP addresses.
- **EC2 Instance**: Launches an Amazon Linux 2 EC2 instance with Docker and Docker Compose pre-installed.

### 2. Storing Terraform State in S3

The Terraform state is stored in an AWS S3 bucket (`dakuchi-bucket`) to:
- Enable team members to access the current state of infrastructure
- Prevent state conflicts by locking the state file
- Keep a secure and versioned record of the infrastructure state

### 3. EC2 Instance Setup with Entry Script

Upon launching, the EC2 instance runs the `entry_script.sh` to:
- **Install Docker and Docker Compose**: Enables Docker-based deployment by installing and starting Docker, and setting up Docker Compose.
- **Add `ec2-user` to the Docker Group**: Allows the default user to execute Docker commands without requiring `sudo`.

The Terraform configuration automatically assigns the public IP to the EC2 instance, making it accessible for deployment. For more details on the Infrastructure Provisioning setup using Terraform, see the [deploy-to-ec2-default-components](https://github.com/Dakuchi/terraform-project/tree/feature/deploy-to-ec2-default-components).

## Requirements

The following are required for the Terraform provisioning stage:
- **AWS CLI Credentials**: Set up in Jenkins to provide access to AWS resources. Ensure `jenkins_aws_access_key_id` and `jenkins_aws_secret_access_key` credentials are configured.
- **Terraform**: Installed in the Jenkins environment to execute infrastructure setup.

For more on setting up AWS CLI and Terraform, refer to [AWS CLI Documentation](https://aws.amazon.com/cli/) and [Terraform Documentation](https://developer.hashicorp.com/terraform/docs).

## Pipeline Stages

1. **Build App**: Builds the application JAR using Maven. [See details](https://github.com/Dakuchi/java-maven-app/tree/jenkins-pipeline).
2. **Build and Push Docker Image**: Builds the Docker image and pushes it to Docker Hub. [See details](https://github.com/Dakuchi/java-maven-app/tree/jenkins-pipeline).
3. **Provision Server** (Updated in this Branch):
   - Uses Terraform to provision the infrastructure and create an EC2 instance.
   - Stores the Terraform state in an S3 bucket for shared access.
   - Configures the EC2 instance with Docker and Docker Compose for deployment.
4. **Deploy to EC2**: Copy and execute the `server-cmds.sh` on the provisioned EC2 instance using SSH, the `server-cmd.sh` login to Docker Hub and run `docker-compose.yaml` file to deploy docker container.

## Usage

1. **Set Up Jenkins Configuration**:
   - Ensure AWS CLI credentials are available in Jenkins as `jenkins_aws_access_key_id` and `jenkins_aws_secret_access_key`.
   - Verify that Terraform is installed in the Jenkins environment.

2. **Run the Pipeline**:
   - The pipeline will provision the required AWS infrastructure, build and push the Docker image, and deploy to the EC2 instance.

3. **Verify Provisioning and Deployment**:
   - After deployment, check the EC2 instance to confirm the Docker container is running with the latest application version.
