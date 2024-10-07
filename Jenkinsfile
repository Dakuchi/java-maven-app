#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master' , retriever: modernSCM(
// Jenkins shared library
    [
        $class: 'GitSCMSource',
        remote: 'git@github.com:Dakuchi/jenkins-shared-library.git',
        credentialsId: 'github-sshkey'
    ]
)

pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    environment {
        IMAGE_NAME = 'dakuchi/demo-app:java-maven-2.0'
    }
    stages {
        stage("build app") {
            steps {
                script {
					echo 'building application jar...'				
					buildJar()
                }
            }
        }
        stage("build image") {
            // build image and push to docker hub
            steps {
                script {
                    echo "building image..."
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }
        stage("provision server") {
            // terraform provision server
            steps {
                environment {
                    AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                    AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
                    TF_VAR_env_prefix = 'test'
                }
                script {
                    dir("terraform") {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2_public_ip",
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
        stage("deploy") {
            // copy the docker compose and bash file to deploy the image to EC2 instance
            steps {
                script {
                    echo "waiting for EC2 server to initialize..."
                    sleep(time: 60, unit: "SECONDS")

                    echo "deploying docker image to EC2 ..."
                    echo "The EC2 public IP is: ${EC2_PUBLIC_IP}"
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"

                    sshagent(['server-ssh-key']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ec2Instance:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ec2Instance:/home/ec2-user" 
                        sh "ssh -o StrictHostKeyChecking=no ec2Instance ${shellCmd}"
                    }
                }
            }
        }
    }   
}