pipeline {
    agent any

    environment {
        EC2_HOST = "ec2-user@3.108.60.38"
        APP_NAME = "product-service"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/amitamitmm/product-service.git'
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
                ssh -o StrictHostKeyChecking=no $EC2_HOST '
                docker stop product-service || true
                docker rm product-service || true
                docker run -d -p 8080:8080 --name product-service product-service
                '
                """
            }
        }
    }
}