pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker build -t antsman/rpi-smashing:${env.BUILD_ID} .'
            }
        }
        stage('test') {
            steps {
                sh 'docker run antsman/rpi-smashing:${env.BUILD_ID} smashing'
            }
        }
    }
}
