pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker build -t antsman/rpi-smashing .'
            }
        }
        stage('test') {
            agent { docker { image 'antsman/rpi-smashing' } }
            steps {
                sh 'smashing'
                sh 'wget --spider http://localhost:3030'
            }
        }
    }
}
