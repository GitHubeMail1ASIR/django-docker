pipeline {
    environment {
        IMAGENAME = 'githubemail1asir/django_practica_jenkins'
        LOGIN = 'USER_DOCKER_HUB'
    }
    agent none
    stages {
        stage('Tests Django') {
            agent {
                docker {
                    image 'python:3'
                    args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main',url:'https://github.com/GitHubeMail1ASIR/django-docker.git'
                    }
                }
                stage('Pip Install') {
                    steps {
                        sh 'pip install --root-user-action=ignore --upgrade pip'
                        sh 'pip install --root-user-action=ignore django mysqlclient'
                    }
                }
                stage('Tests') {
                    steps {
                        sh 'python3 manage.py test'
                    }
                }
            }
        }
        stage('Construcción imagen docker') {
            agent any
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main',url:'https://github.com/GitHubeMail1ASIR/django-docker.git'
                    }
                }
                stage('Build') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGENAME:latest"
                        }
                    }
                }
                stage('Subir Imagen') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('Borrar Imagen') {
                    steps {
                        sh 'docker rmi $IMAGENAME:latest'
                    }
                }
            }
        }
    }
    post {
        always {
            mail to: 'jjas-asir2@Debian',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
