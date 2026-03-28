pipeline {
    agent any

    environment {
        EC2_HOST = "ec2-user@43.205.236.125"
        APP_NAME = "product-service"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/amitamitmm/product-service.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t product-service .'
            }
        }

        stage('Deploy to EC2') {
             steps {
                   sh """
                   ssh -i /var/lib/jenkins/.ssh/first-key-pair.pem -o StrictHostKeyChecking=no ec2-user@43.205.236.125 '
                       docker stop product-service || true
                       docker rm product-service || true
                       docker run -d -p 8080:8080 --name product-service product-service
                   '
                   """
               }
        }
    }
}