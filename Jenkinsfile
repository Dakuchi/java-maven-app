#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master' , retriever: modernSCM(
    [
        $class: 'GitSCMSource',
        remote: 'git@github.com:Dakuchi/jenkins-shared-library.git',
        credentialsId: 'github-sshkey'
    ]
)

def gv

pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    environment {
        IMAGE_NAME = 'dakuchi/demo-app:java-maven-1.0'
    }
    stages {
        stage("build jar") {
            steps {
                script {
                    buildJar()
                    //gv.buildJar()
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building image"
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                    //gv.buildImage()
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    def ec2IP = '18.139.227.202'
                    def dockerComposeCmd = "docker compose -f docker-compose.yaml up --detach"
                    sshagent(['ec2-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ec2-user@${ec2IP}:/home/ec2-user" 
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@${ec2IP} ${dockerComposeCmd}"
                    }
                }
            }
        }
    }   
}