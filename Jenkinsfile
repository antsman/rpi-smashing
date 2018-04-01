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
                sh "docker run antsman/rpi-smashing:${env.BUILD_ID} sh -c 'smashing && wget --spider http://localhost:3030'"
            }
        }
    }
}
