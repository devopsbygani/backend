@Library('jenkins-shared-library') _ // gets the global pipeline libraries in system configuration

def configMap = [
    project: "expense"     // these are passed to pipeline.
    component: "backend"
]

if( ! env.BRANCH_NAME.equalsIgnoreCase('main')){ // true, if branch is feature branch
    nodeJSEKSpipeline(configmap)   // calling the function from nodeJSEKSpipeline
}
else{
    echo "Follow the process of PROD release"
}
