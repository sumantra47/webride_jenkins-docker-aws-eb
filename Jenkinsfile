pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = 'AKIAX5A4JUR26ZLI42OK'
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
