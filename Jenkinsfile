pipeline {
    agent any

    tools {
        terraform 'Terraform-1.16.4'
    }

    environment {
        TF_CLI_ARGS = "-no-color"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out infrastructure source code...'
                checkout scm
            }
        }

        stage('Terraform Init & Validate') {
            steps {
                echo 'Initializing and validating configuration...'
                sh 'terraform init'
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Generating execution plan...'
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval Gate') {
            steps {
                script {
                    input message: 'Do you approve deploying this infrastructure container?',
                          ok: 'Approve & Apply'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                echo 'Applying infrastructure changes...'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            sh 'rm -f tfplan'
        }
        success {
            echo 'Infrastructure applied successfully! App running on port 8085.'
        }
        failure {
            echo 'Pipeline failed. Check build logs.'
        }
    }
}
