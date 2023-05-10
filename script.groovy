def buildJar() {
    echo "building the application..."
    sh 'mvn package'
} 

def buildImage() {
    echo "building the docker image..."
    withCredentials([usernamePassword(credentialsId: 'DockerHubp', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                           sh 'docker build -t padmandl/myrepo:jma-5.0 .'
                           sh "echo $PASS | docker login -u $USER --password-stdin"
                           sh 'docker push padmandl/myrepo:jma-5.0'
                       }
} 

def deployApp() {
    echo 'deploying the application...'
} 

return this
