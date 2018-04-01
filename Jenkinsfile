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
                sh "docker run antsman/rpi-smashing:${env.BUILD_ID} sh -c 'smashing-start & sleep 180 && ps && wget --spider http://localhost:3030'"
            }
        }
    }
    post {
        success {
            echo 'Build succeeded, push image ..'
        }
    }
}
