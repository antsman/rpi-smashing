node {
    checkout scm

    def customImage = docker.build("antsman/rpi-smashing:${env.BUILD_ID}")

    customImage.inside {
        sh 'smashing'
        sh 'wget --spider http://localhost:3030'
    }
}
