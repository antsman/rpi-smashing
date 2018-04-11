#!/groovy

pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('DOCKER_HUB_CREDS')
        IMAGE_NAME = 'antsman/rpi-smashing'
        IMAGE_TAG = 'build-test'
        CONTAINER_NAME = 'rpi-smashing-dev'
    }
    stages {
        stage('BUILD') {
            steps {
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }
        stage('TEST') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
	            sh "docker run -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG"
	            sh "docker exec -t $CONTAINER_NAME sh -c 'sleep 60 && get --spider http://localhost:3030'"
	            sh "time docker stop $CONTAINER_NAME"
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
