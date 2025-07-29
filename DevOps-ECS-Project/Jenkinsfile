pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-ecs-app"
        REPO = "your-jfrog-domain.jfrog.io/devops-docker"  // Update this to your actual JFrog Docker repo
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Devtools-Prajna/DevOps.git'
            }
        }

        stage('Test') {
            steps {
                dir('DevOps-ECS-Project') {
                    sh 'python3 -m py_compile app.py'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('DevOps-ECS-Project') {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Push to JFrog') {
            steps {
                withCredentials([usernamePassword(credentialsId: '297d4d4e-4f3f-411c-b57c-3eb87950bc4e', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    docker login -u $USERNAME -p $PASSWORD your-jfrog-domain.jfrog.io
                    docker tag $IMAGE_NAME $REPO/$IMAGE_NAME:latest
                    docker push $REPO/$IMAGE_NAME:latest
                    """
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('DevOps-ECS-Project/terraform') {
                    withCredentials([
                        string(credentialsId: '4e622415-e750-47fc-b631-bbd0c8c9fcbe', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: '4e622415-e750-47fc-b631-bbd0c8c9fcbe', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh '''
                        terraform init
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
