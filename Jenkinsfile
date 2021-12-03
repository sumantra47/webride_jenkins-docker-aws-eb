pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = 'AKIAX5A4JUR27FSFJ2XJ'
        AWS_SECRET_ACCESS_KEY = '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'
    }
    stages {
        stage('Build') {
            steps {
                sh 'echo "Building"'
                sh 'echo $AWS_ACCESS_KEY_ID'
                sh 'echo $AWS_SECRET_ACCESS_KEY'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Testing"'
            }
        }
        stage('Publish') {
            steps {
                sh 'echo "Publishing"'
            }
            post {
                success {
                    sh 'echo "Deploying to EB"'
                    sh 'sudo chmod 775 ./deployme.sh'
                    sh './deployme.sh'
                }
            }
        }
    }
}
