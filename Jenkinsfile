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
            / build image and push to docker hub
            steps {
                script {
                    echo "building image..."
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }
        stage("provision server"){
            // terraform provision server

        }
        stage("deploy") {
            // copy the docker compose and bash file to deploy the image to EC2 instance
            steps {
                script {
                    
                    def ec2Instance = 'ec2-user@18.139.227.202'
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"

                    sshagent(['ec2-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ec2Instance:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ec2Instance:/home/ec2-user" 
                        sh "ssh -o StrictHostKeyChecking=no ec2Instance ${shellCmd}"
                    }
                }
            }
        }
    }   
}