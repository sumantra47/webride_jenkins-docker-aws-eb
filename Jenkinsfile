pipeline {
    agent any 
    stages {
        stage('Build') {
            // build stage
        }
        stage('Test') {
           // test stage
        }
        stage('Publish') {
            steps {
                sh 'echo "Publishing"'
            }
            post {
                success {
                    sh 'echo "Deploying to EB"'
                    sh './deployme.sh'
                }
            }
        }
    }
}
