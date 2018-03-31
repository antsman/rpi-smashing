node {
    checkout scm

    def customImage = docker.build("antsman/rpi-smashing:${env.BUILD_ID}")

    docker.image("antsman/rpi-smashing:${env.BUILD_ID}").inside {
/*
    customImage.inside {
*/
        sh 'ls -l'
        sh 'smashing'
        sh 'wget --spider http://localhost:3030'
    }
}
