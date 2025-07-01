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
                // docker build -t expense/backend:${appVersion} .
                docker images
                // docker tag expense/backend:${appVersion} 905418383993.dkr.ecr.us-east-1.amazonaws.com/expense/backend:${appVersion}
                // docker push 905418383993.dkr.ecr.us-east-1.amazonaws.com/expense/backend:${appVersion}
                """
            }

        }

        stage ('deploy') {
            steps {
                echo 'configure aws credentials' // use kubernets admin iam role key configure , plugin : aws credential & aws steps
                echo 'backend helm file in this folder, redirect to it' 
                echo 'sed -i 's/IMAGE_VERSION/${appVersion}/g' values-${environment}.yaml'  
                // i - replace in IMAGE_VERSION value with $appversion value , target file is values-dev.yaml
                echo 'helm upgrade -- install backend -n <namespace> -f <values-dev.yaml> .'
            
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



