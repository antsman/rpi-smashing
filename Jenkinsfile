pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('DOCKER_HUB_CREDS')
        IMAGE_NAME = 'antsman/rpi-smashing'
        IMAGE_TAG = 'build-test'
    }
    stages {
        stage('BUILD') {
            steps {
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }
        stage('TEST') {
            steps {
                sh "docker run $IMAGE_NAME:$IMAGE_TAG sh -c 'smashing-start & sleep 60 && ps && wget --spider http://localhost:3030'"
            }
        }
    }
    post {
        success {
            echo 'Build succeeded, push image ..'
            sh "docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest"
            sh "docker rmi $IMAGE_NAME:$IMAGE_TAG"
            sh "docker login -u $DOCKER_CREDS_USR -p $DOCKER_CREDS_PSW"
            sh "docker push $IMAGE_NAME:latest"
        }
    }
}
