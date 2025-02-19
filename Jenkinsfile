pipeline {
    agent any

    environment {
        PROJECT_ID = 'pvt-stage'
        GKE_CLUSTER = 'gke-cluster02'
        GKE_ZONE = 'asia-south1'
        IMAGE_NAME = "gcr.io/${PROJECT_ID}/nginx"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/sahilhr24/jenkins-to-gke.git'
            }
        }

        stage('Authenticate GCloud') {
            steps {
                sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                sh 'gcloud auth configure-docker'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
            }
        }

        stage('Push Image to Artifact Registry') {
            steps {
                sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
            }
        }

        stage('Deploy to GKE') {
            steps {
                sh 'gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_ZONE --project $PROJECT_ID'
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
