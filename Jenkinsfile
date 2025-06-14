pipeline {
    agent {
        label 'AGENT-1'
    }

    environment {
        appVersion = '' //global variable
    }

    stages {
        stage ('read package json') { //Pipeline Utility Steps plugin.
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "app version: ${appVersion}"
                }
            }
        }

        stage ('docker image build') {
            steps {
                sh """
                docker build -t promptai/backend:${appVersion} .
                docker images
                """
            }

        }
    }
    
    post { 
        always { 
            echo 'Deleting workspace artifacts...!'  // this always executes if pipeline fail or success.
            deleteDir()

        }

        failure {
            echo 'I willsay Hello if pipeline fail!'  // this will executes if pipeline fail
        }

        success {
            echo 'I willsay Hello if pipeline success!'  // this will executes if pipeline success
        }

    }
}



