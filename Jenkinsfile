//  Deploying single tier HTML web aplication, using jekins pipeline.
//  it will automatically build image, run image, and deploy in VM server.
//  it also push image locall to docker hub, all done with jenkins pipeline.

pipeline
{
    agent slave
    stages
    {
        stage( "Clean" )
        {
            steps
            {
                sh ' rm -rf /var/lib/jenkins/workspace/Web-Slave-1/* '
            }
        }
        stage("Clean Containers and Images")
        {
            steps
            {
                script
                {
                    def containers = sh(script: 'sudo docker ps -a -q', returnStdout: true).trim()
                    if (containers)
                    {
                        sh "sudo docker stop $containers"
                        sh "sudo docker rm $containers"
                        echo "Containers successfully deleted!!"
                    } else
                    {
                        echo "No containers are there to delete!!"
                    }

                    def images = sh(script: 'sudo docker images -q', returnStdout: true).trim()
                    if (images)
                    {
                        sh "sudo docker rmi $images"
                        echo "Images successfully deleted!!"
                    } else
                    {
                        echo "No images are there to delete!!"
                    }
                }
            }
        }
        stage( "Clone" )
        {
            steps
            {
                sh ' git clone -b Barista https://github.com/RameshXT/PRACTICE-1.git '
            }
        }
        stage( "Switch Directory" )
        {
            steps
            {
                script
                {
                    def directoryPath = '/var/lib/jenkins/workspace/Web-Slave-1/PRACTICE-1'
                    dir(directoryPath)
                    {
                        echo "Currently in directory: ${pwd()}"
                    }
                        echo "Back to the original working directory: ${pwd()}"
                }
            }
        }
        stage( "Build" )
        {
            steps
            {
                sh ' docker build -t rameshxt/docker:${BUILD_NUMBER} /var/lib/jenkins/workspace/Web-Slave-1/PRACTICE-1 '
            }
        }
        stage( "Run" )
        {
            steps
            {
                sh ' docker run -it -d --name barista -p 80:80 rameshxt/docker:${BUILD_NUMBER} '
            }
        }
        stage( "Docker Login" )
        {
            steps
            {
                script
                {
                    withCredentials([string(credentialsId: 'Dockerid', variable: 'DockerPasswd')]) 
                    {
                        sh ' docker login -u rameshxt -p ${DockerPasswd} '
                    }
                }
            }
        }
        stage( "Pushing to DockerHub" )
        {
            steps
            {
                script
                {
                    withCredentials([string(credentialsId: 'Dockerid', variable: 'Dockerpasswd')]) 
                    {
                        sh ' docker push rameshxt/docker:${BUILD_NUMBER} '
                    }
                }
            }
        }
    }
}
