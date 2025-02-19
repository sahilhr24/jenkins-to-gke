pipeline {
    agent any

    environment {
        PROJECT_ID = 'pvt-stage'
        GKE_CLUSTER = 'gke-cluster02'
        GKE_ZONE = 'asia-south1'
        IMAGE_NAME = 'asia-south1-docker.pkg.dev/pvt-stage/cloud-run-source-deploy/my_custom_nginx:latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/jenkins-to-gke.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
            }
        }

        stage('Push Image to Artifact Registry') {
            steps {
                sh 'gcloud auth configure-docker'
                sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
            }
        }

        stage('Deploy to GKE') {
            steps {
                sh 'gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_ZONE --project $PROJECT_ID'
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }
}
