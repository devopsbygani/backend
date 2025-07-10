pipeline {
    agent {
        label 'AGENT-1'
    }
 
    environment {
        appVersion = '' //global variable
        environment = 'dev'
        project = 'expense'
        component = 'backend'
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
                withAWS(region: 'us-east-1', credentials: 'aws-cred') {
                    sh """
                                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 905418383993.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t expense/backend:${appVersion} .
                    docker images
                    docker tag expense/backend:${appVersion} 905418383993.dkr.ecr.us-east-1.amazonaws.com/expense/backend:${appVersion}
                    docker push 905418383993.dkr.ecr.us-east-1.amazonaws.com/expense/backend:${appVersion}
                    """
                 } 
            }

        }

        stage ('deploy') {
            steps {
                withAWS(region: 'us-east-1', credentials: 'aws-cred') {
                    sh """
                    aws eks update-kubeconfig --region us-east-1 --name ${project}-${environment}
                    cd helm
                    sed -i 's/IMAGE_VERSION/${appVersion}/g' values-${environment}.yaml
                    helm upgrade --install ${component} -n ${project} -f values-${environment}.yaml .
                    """
                }
                // i - replace in IMAGE_VERSION value with $appversion value , target file is values-dev.yaml          
            }

        }
    }
    
    post { 
        always { 
            echo 'Deleting workspace artifacts...!'  // this always executes if pipeline fail or success.
            deleteDir()

        }

        failure {
            echo 'pipeline is fail!'  // this will executes if pipeline fail
        }

        success {
            echo 'pipeline is success!'  // this will executes if pipeline success
        }

    }
}



