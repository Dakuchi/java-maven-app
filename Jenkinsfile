pipeline {
    agent any
	environment {
		ANSIBLE_SERVER = "34.142.149.65"
	}
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "coppying all necessary files to ansible control node"
                    sshagent(['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* root@${ANSIBLE_SERVER}:/root"
                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
	                        sh 'scp $keyfile root@$ANSIBLE_SERVER:/root/ssh-key.pem'
                        }
                    }
                }
            }
        }
		stage("execute ansible playbook") {
			steps {
				script{
					echo "calling ansible playbook to configure ec2 instance"
                    
                    // Create object for remote ssh 
					def remote = [:]
					remote.name = "ansible-server"
					remote.host = ANSIBLE_SERVER
					remote.allowAnyHosts = true

					// Use ssh plugin to execute command on remote server
					withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
						remote.user = user
						remote.identityFile = keyfile
						sshCommand remote: remote, command: "ls -l"
						sshScript remote: remote, script: "prepare-ansible-server.sh"
						sshCommand remote: remote, command: "ansible-playbook my-playbook.yaml"
					}
				}
			}
		}
    }   
}
