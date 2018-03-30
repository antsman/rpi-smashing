pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker build -t antsman/rpi-smashing .'
            }
        }
        stage('test') {
            steps {
                sh 'docker run antsman/rpi-smashing smashing_test'
            }
        }
    }
}
