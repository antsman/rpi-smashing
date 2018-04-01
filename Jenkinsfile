pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('DOCKER_HUB_CREDS')
        IMAGE_NAME = 'antsman/rpi-smashing'
        IMAGE_TAG = 'test-build'
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
            sh "docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME"
            sh "docker login -u $DOCKER_HUB_CREDS_USR -p $DOCKER_HUB_CREDS_PSW"
            sh 'docker push antsman/rpi-smashing:latest'
            sh 'docker push antsman/rpi-smashing'
        }
    }
}
