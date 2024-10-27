# Jenkins pipeline with Ansible Integration for EC2 Configuration

This branch extends the Jenkins pipeline by integrating Ansible to dynamically configure EC2 instances on AWS. The setup includes:
- Jenkins initiating a connection to an Ansible control node
- Ansible control node connecting to AWS EC2 instances using dynamic inventory through the `aws_ec2` plugin
- Installing and configuring packages on the EC2 instances via Ansible playbooks
  
![Ansible-integration](https://github.com/user-attachments/assets/a6af4fc3-395e-4511-b28d-c55478186199)

## Overview

The updated CI/CD pipeline architecture:

#### 1. **Jenkins** connects to the Ansible server and triggers the Ansible playbook.
#### 2. **Ansible Server** dynamically discovers EC2 instances using the `aws_ec2` plugin and applies the configuration playbook.

## Requirements

To support Ansible integration with Jenkins, the following are required:

### 1. Jenkins Requirements

- **Ansible Installed**: Ansible must be installed in Jenkins.
- **SSH Command Plugin**: Required for secure SSH communication between Jenkins and the Ansible control node.
- **AWS Credentials**: Stored in Jenkins to allow the Ansible `aws_ec2` plugin to query AWS EC2 instances dynamically.

### 2. Ansible Configuration
Following files locate in `ansible` folder.

- **Ansible Inventory File**: An `inventory_aws_ec2.yaml` file configured with the `aws_ec2` plugin for dynamic inventory.
- **Ansible Playbook**: The playbook (`my-playbook.yaml`) installs required packages and tools on the EC2 instances.
- **Ansible Configuration File**: The `ansible.cfg` file, along with the playbook and inventory file, are located in the `ansible` folder within the repository.


## Pipeline Stages

1. **Copy Files to Ansible Server**:
   - Copies configuration files, SSH keys, and the `prepare-ansible-server.sh` setup script to the Ansible control node.
   - The SSH agent is used to securely connect to the Ansible server.

2. **Execute Ansible Playbook**:
   - Configures the Ansible server with `prepare-ansible-server.sh` if needed.
   - Executes `my-playbook.yaml` to install necessary packages on the target EC2 instances.
   - The playbook uses dynamic inventory with the `aws_ec2` plugin to locate and connect to instances.

## Ansible Playbook: Key Tasks

The `my-playbook.yaml` playbook contains the following key tasks for configuring EC2 instances:

1. **Install Python3 and Docker**: Ensures `python3` and `docker` are installed and Docker is running.
2. **Downgrade urllib3**: Uninstalls existing `urllib3` and installs version 1.26.7 to meet compatibility requirements.
3. **Install Docker Compose**: Downloads and installs Docker Compose.
4. **Start Docker Daemon**: Starts the Docker service to allow container management.
5. **Install Python Docker Modules**: Installs `docker` and `docker-compose` Python modules for managing Docker from Python scripts.

## Configuration Details

### 1. Ansible Server Setup

The `prepare-ansible-server.sh` script sets up the Ansible control node with:
- **Ansible Installation**: Installs Ansible and dependencies.
- **AWS SDK**: Installs `boto3` and `botocore` for AWS interaction via Ansible.

### 2. Dynamic Inventory

The `inventory_aws_ec2.yaml` file configures Ansible to query AWS for EC2 instances in a specified region, dynamically updating the inventory based on tags and instance properties.

### 3. Security and Credentials

- **SSH Keys**: Jenkins uses `ansible-server-key` to connect to the Ansible server. The Ansible server uses `ec2-server-key` to connect to EC2 instances.
- **AWS Credentials**: The `aws_ec2` plugin requires AWS credentials stored in Jenkins to query EC2 instances dynamically.
