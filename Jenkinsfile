def gv


pipeline {
    agent any
    tools {
          maven 'maven-3.9'

        }
    stages {
        stage("init") {
            steps {
                script {
                echo "Initialize groovy"
                    gv = load "script.groovy"
                }
            }
        }
        stage("build jar") {
            steps {
                script {

                    echo "building jar"
                   echo "building the application..."
                    gv.buildJar()
                    //npm,maven,npm--build tools
                     //sh 'mvn package' -- create jar file
                    //sh "$mvnHome/bin/mvn package"

                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building image"
//                     withCredentials([usernamePassword(credentialsId: 'DockerHubp', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
//                            sh 'docker build -t yedukondaluch/image99 :jma-2.0 .'
//                            sh "echo $PASS | docker login -u $USER --password-stdin"
//                            sh 'docker push yedukondaluch/image99:jma-2.0'
//                        }
                    
                    gv.buildImage()
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "deploying"
                    //def dockerCmd = 'docker run -p 3080:3080 -d yedukondaluch/image99:jma-4.0'
                    def dockerComposeCmd = "docker-compose -f /home/docker-composee.yml up --detach"
                    //def shellCmd = "bash /home/server-cmds.sh"
                    sshagent(['digital-ocean-server']) {
                        //sh "ssh -o StrictHostKeyChecking=no root@143.244.161.134 ${dockerCmd}"
                        //sh "scp server-cmds.sh root@143.244.161.134:/home/"
                        sh "scp docker-composee.yml root@143.244.161.134:/home/"
                        sh "ssh -o StrictHostKeyChecking=no root@143.244.161.134 ${dockerComposeCmd}"
                        //sh "ssh -o StrictHostKeyChecking=no root@143.244.161.134 ${shellCmd}"
                    }
                }
            }
        }
    }   
}
