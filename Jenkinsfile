pipeline {
    agent any

    environment {
        PROJECT_ID = 'pvt-stage'
        GKE_CLUSTER = 'gke-cluster02'
        GKE_ZONE = 'asia-south1'
        ARTIFACT_REPO = 'asia-south1-docker.pkg.dev'
        IMAGE_NAME = '${ARTIFACT_REPO}/${PROJECT_ID}/my-app'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/sahilhr24/jenkins-to-gke.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
            }
        }

        stage('Push Image to Artifact Registry') {
            steps {
                sh 'gcloud auth configure-docker $ARTIFACT_REPO'
                sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
            }
        }

        stage('Deploy to GKE') {
            steps {
                sh 'gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_ZONE --project $PROJECT_ID'
                sh 'kubectl set image deployment/my-app my-app=$IMAGE_NAME:$BUILD_NUMBER -n default'
                sh 'kubectl rollout status deployment/my-app -n default'
            }
        }
    }
}
