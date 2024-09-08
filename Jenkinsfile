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
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
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
        stage("deploy") {
        // copy the docker compose and bash file to deploy the image to EC2 instance
            steps {
                script {
                    def ec2IP = '18.139.227.202'
                    //def dockerComposeCmd = "docker compose -f docker-compose.yaml up --detach"
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                    sshagent(['ec2-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ec2-user@${ec2IP}:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ec2-user@${ec2IP}:/home/ec2-user" 
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@${ec2IP} ${shellCmd}"
                    }
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
                        sh 'git push origin HEAD:Version-increment'
                    }
                }
            }
        }
    }   
}
