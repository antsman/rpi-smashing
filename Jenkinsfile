#!/groovy

pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('DOCKER_HUB_CREDS')
        IMAGE_NAME = 'antsman/rpi-smashing'
        IMAGE_TAG = "jenkins-$BRANCH_NAME"
        CONTAINER_NAME = "$BUILD_TAG"
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
	            sh "docker run -d --rm --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG"
                    sh 'env'
                    sleep 60
                    sh "docker exec -t $CONTAINER_NAME wget --spider http://localhost:3030"
//                  sh "docker logs $CONTAINER_NAME"
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
    post {
        failure {
	    sh "docker rm -f $CONTAINER_NAME"
        }
    }
}
