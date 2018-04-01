pipeline {
    agent any
    environment {
        DOCKER_USER = "testuser"
        DOCKER_PASS = "testpass"
        IMAGE = "antsman/rpi-smashing"
        TAG = "test-build"
    }
    stages {
        stage('Build') {
            steps {
                sh "docker build -t antsman/rpi-smashing:test-build ."
            }
        }
        stage('Test') {
            steps {
                sh 'printenv'
                sh "docker run antsman/rpi-smashing:test-build sh -c 'smashing-start & sleep 60 && ps && wget --spider http://localhost:3030'"
            }
        }
    }
    post {
        success {
            echo 'Build succeeded, push image ..'
            sh "docker tag antsman/rpi-smashing:test-build antsman/rpi-smashing:latest"
            sh "docker tag antsman/rpi-smashing:test-build antsman/rpi-smashing"
/*
            sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
            sh 'docker push antsman/rpi-smashing:latest'
            sh 'docker push antsman/rpi-smashing'
*/
        }
    }
}
