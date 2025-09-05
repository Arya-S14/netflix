pipeline {
  agent any
  environment {
    IMAGE_NAME     = "hp/netflix-app"
    IMAGE_TAG      = "${env.BUILD_NUMBER}"
    CONTAINER_NAME = "netflix-container"
    APP_PORT       = "8082"   // host port
    INTERNAL_PORT  = "80"     // nginx container port
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG -t $IMAGE_NAME:latest .'
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                          usernameVariable: 'DOCKERHUB_USER',
                                          passwordVariable: 'DOCKERHUB_PASS')]) {
          sh '''
            echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
            docker push $IMAGE_NAME:$IMAGE_TAG
            docker push $IMAGE_NAME:latest
            docker logout
          '''
        }
      }
    }

    stage('Deploy (Local)') {
      steps {
        sh '''
          docker rm -f $CONTAINER_NAME || true
          docker run -d --name $CONTAINER_NAME -p ${APP_PORT}:${INTERNAL_PORT} $IMAGE_NAME:latest
        '''
      }
    }
  }
  post {
    success {
      echo "App should be reachable at http://<jenkins-host>:$APP_PORT"
    }
  }
}
