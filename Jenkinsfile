pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "docker build -t antsman/rpi-smashing:${env.BUILD_ID} ."
            }
        }
        stage('Test') {
            steps {
                sh "docker run antsman/rpi-smashing:${env.BUILD_ID} sh -c 'smashing-start & sleep 60 && ps && wget --spider http://localhost:3030'"
            }
        }
    }
    post {
        success {
            echo 'Build succeeded, push image ..'
            sh "docker tag antsman/rpi-smashing:${env.BUILD_ID} antsman/rpi-smashing:latest"
            sh "docker tag antsman/rpi-smashing:${env.BUILD_ID} antsman/rpi-smashing"
            sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
        }
    }
}
