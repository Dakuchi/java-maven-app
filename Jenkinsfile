#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master' , retriever: modernSCM(
// Jenkins shared library
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
    stages {
        stage('increment version'){
        // increase the version from pom.xml file
            steps{
                script{
                    echo 'incrementing app version...'
                    sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "dakuchi/demo-app:$version-$BUILD_NUMBER"
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                    buildJar()
                    //gv.buildJar()
                }
            }
        }
        stage("build image") {
        // build image and push to docker hub
            steps {
                script {
                    echo "building image"
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                    //gv.buildImage()sd
                }
            }
        }
        stage('deploy') {
            environment {
               AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
               AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
               APP_NAME = 'java-maven-app'
            }
            steps {
                script {
                   echo 'deploying docker image...'
                   sh 'envsubst < deployment and service config/deployment.yaml | kubectl apply -f -'
                   sh 'envsubst < deployment and service config/service.yaml | kubectl apply -f -'
                }
            }
        }
        stage('commit version update') {
        // update the newly built version to github pom.xml file
            steps{
                script{
                    withCredentials([sshUserPrivateKey(credentialsId: 'github-sshkey', keyFileVariable: 'SSH_KEY')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        // Use SSH instead of HTTPS for Git operations
                        sh "git remote set-url origin git@github.com:Dakuchi/-java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:jenkins-pipeline'
                    }
                }
            }
        }
    }   
}
