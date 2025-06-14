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
                scripts {
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
                """
            }

        }
}
}