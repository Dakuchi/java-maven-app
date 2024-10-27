#!/usr/bin/env groovy

pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    environment {
        ECR_REPO_URL = '935160191755.dkr.ecr.ap-southeast-1.amazonaws.com'
        IMAGE_REPO = "${ECR_REPO_URL}/my-app"
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
        stage("build app") {
        // build jar file
            steps {
                script {
                   echo "building the application..."
                   sh 'mvn clean package'
                }
            }
        }
        stage("build image") {
        // build image and push to AWS ECR
            steps {
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'ec2-server-key', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t ${IMAGE_REPO}:${IMAGE_NAME} ."
                        sh "echo $PASS | docker login -u $USER --password-stdin ${ECR_REPO_URL}"
                        sh "docker push ${IMAGE_REPO}:${IMAGE_NAME}"
                    }
                }
            }

        }
        stage('deploy') {
        // deploy image on AWS EKS cluster
            environment {
               AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
               AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
               APP_NAME = 'java-maven-app'
            }
            steps {
                script {
                   echo 'deploying docker image...'
                   sh 'envsubst < deploy-config/deployment.yaml | kubectl apply -f -'
                   sh 'envsubst < deploy-config/service.yaml | kubectl apply -f -'
                }
            }
        }
        stage('commit version update') {
        // update the newly built version to github pom.xml file
            steps{
                script{
                    withCredentials([sshUserPrivateKey(credentialsId: 'github-sshkey', keyFileVariable: 'SSH_KEY')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        sh "git remote set-url origin git@github.com:Dakuchi/-java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:feature/deploy-on-k8s-ecr'
                    }
                }
            }
        }
    }   
}
