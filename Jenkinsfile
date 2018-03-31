pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'smashing'
                sh 'wget --spider http://localhost:3030'
            }
        }
    }
}
