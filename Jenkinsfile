pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        ECR_REPO = "237586137911.dkr.ecr.ap-south-1.amazonaws.com/product-service"
        EC2_HOST = "ec2-user@43.205.236.125"
        KEY = "/var/lib/jenkins/.ssh/first-key-pair.pem"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/amitamitmm/product-service.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t product-service .'
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region ap-south-1 | \
                docker login --username AWS --password-stdin $ECR_REPO
                '''
            }
        }

        stage('Tag & Push Image') {
            steps {
                sh '''
                docker tag product-service:latest $ECR_REPO:latest
                docker push $ECR_REPO:latest
                '''
            }
        }

        stage('Deploy to EC2') {
             steps {
                    sh """
                    ssh -i /var/lib/jenkins/.ssh/first-key-pair.pem ec2-user@43.205.236.125 '

                        aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 237586137911.dkr.ecr.ap-south-1.amazonaws.com

                        cd /home/ec2-user/app

                        docker-compose down

                        docker-compose pull

                        docker-compose up -d
                    '
                    """
                }
        }
    }
}