#!/groovy

pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('DOCKER_HUB_CREDS')
        IMAGE_NAME = 'antsman/rpi-smashing'
        IMAGE_TAG = 'jenkins-build'
    }
    stages {
        stage('BUILD') {
            steps {
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }
        stage('TEST') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
	            sh "docker run --rm $IMAGE_NAME:$IMAGE_TAG sh -c 'sleep 60 && ps && wget --spider http://localhost:3030'"
                }
            }
        }
        stage('DEPLOY') {
            when {
                branch 'master'
            }
            steps {
                echo 'Build succeeded, push image ..'
                sh "docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest"
                sh "docker login -u $DOCKER_CREDS_USR -p $DOCKER_CREDS_PSW"
                sh "docker push $IMAGE_NAME:latest"
            }
        }
    }
}
