pipeline {
    agent any

    environment {
        PROJECT_ID = 'pvt-stage'
        GKE_CLUSTER = 'gke-cluster02'
        GKE_ZONE = 'asia-south1'
    }

    stages {
        stage('Connect to GKE') {
            steps {
                sh 'gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_ZONE --project $PROJECT_ID'
                sh 'kubectl get nodes'
            }
        }
    }
}
