#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master' , retriever: modernSCM(
    [
        $class: 'GitSCMSource',
        remote: 'git@github.com:Dakuchi/jenkins-shared-library.git',
        credentialsId: 'Jenkins-shared-lib'
    ]
)

def gv

pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    stages {
        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                    //echo "building jar"
                    //gv.buildJar()
                    gv.buildJar()
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    //echo "building image"
                    //gv.buildImage()
                    buildImage 'dakuchi/demo-app:jma-3.0'
                    dockerLogin()
                    dockerPush 'dakuchi/demo-app:jma-3.0'
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "deploying"
                    //gv.deployApp()
                }
            }
        }
    }   
}
