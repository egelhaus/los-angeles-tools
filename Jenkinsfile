pipeline {
    agent any

    stages {
            
        stage('Update System') {
            steps {
                sh """
                    apt update
                    apt upgrade -y
                    apt install python3 python3-venv python3-pip python3-full npm -y
                    exit 0
                """
                  }
        }
        stage('Initialize Python') {
            steps {
                sh """
                   python3 -m venv venv
                   . venv/bin/activate
                   exit 0
                """
                 }
         }
        stage('Install or Update Python Packages') {
            steps {
                sh """
                   . venv/bin/activate
                   pip install --break-system-packages -r requirements.txt
                   exit 0
                """
                 }
         }
        stage('Initialize Server') {
            steps {
                sh """
                  chmod +x run_with_timeout.sh
                  ./run_with_timeout.sh
                """
                 }
         }
     }
 }
