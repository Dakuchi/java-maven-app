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
    enviroment {
        IMAGE_NAME = 'dakuchi/demo-app:1.0'
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
                    def dockerCmd = 'docker run -p 3080:3080 -d dakuchi/demo-app:1.0'
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@ec2-54-255-235-246.ap-southeast-1.compute.amazonaws.com ${dockerCmd}"
                    }
                }
            }
        }
    }   
}