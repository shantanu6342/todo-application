pipeline{
    agent any
    environment{
        DOCKER_IMAGE='todo-application-image:latest'
    }
    stages{
        stage('Clone Repository'){
            steps{
                script {
                    sh 'git clone https://github.com/shantanu6342/todo-application.git'
                    sh 'cd todo-application'
                }
            }
        }
        stage('Build with Maven'){
            steps{
                script {
                    sh 'cd todo-application && mvn clean package -DskipTests'
                }
            }
        }
        stage('Build Docker Image'){
            steps{
                script {
                    sh 'cd todo-application && docker build -t todo-application-image:latest .'
                }
            }
        }
        stage('Push Docker Image to Docker Hub'){
            steps{
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        sh 'docker tag $DOCKER_IMAGE $DOCKER_USER/$DOCKER_IMAGE'
                        sh 'docker push $DOCKER_USER/$DOCKER_IMAGE'
                    }
                }
            }
        }
        stage('Deploy with Docker Compose'){
            steps{
                script{
                    sh 'cd todo-application && docker compose up -d'
                }
            }
        }
        stage('Verify Services'){
            steps{
                script{
                    sh 'docker ps -a'
                }
            }
        }
        stage('Clean Workspace'){
            steps{
                script{
                    sh 'rm -rf *'
                }
            }
        }
    }
}