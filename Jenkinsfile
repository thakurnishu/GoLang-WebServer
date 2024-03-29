@Library('Jenkins-Shared-Lib') _

pipeline{
    agent any 
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
        JENKINS_USER= credentials('jenkins-user')
        JENKINS_USER_TOKEN= credentials('jenkins-user-token')
        JENKINS_IP= credentials('jenkins-ip')
        JENKINS_PORT= credentials('jenkins-port')
        JENKINS_CD_JOB_NAME= 'GO-webserver-CD'
        JENKINS_CD_JOB_TOKEN=  'GO-webserver-CD-Job-Token'
        IMAGENAME=  'gowebserver'
        IMAGETAG= "v${BUILD_NUMBER}"
        DOCKERHUB_USER= 'mahakal0510' 
    }
    stages{
        stage('Clean WorkSpace'){
            steps{
                script{
                    cleanWs()
                }
            }
        }
        stage('Git Checkout'){
            steps{
                script{
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/thakurnishu/GoLang-WebServer.git"
                    )
                }
            }
        }
        stage('GO Build'){
            steps{
                script{
                    def buildName = 'WebServerApp'
                    goBuild(buildName)
                }
            }
        }
        stage('Unit Testing'){
            steps{
                script{
                    goTest()
                }
            }
        }
        stage('SonarQube Analysis'){
            steps{
                script{
                    def SonarQube_Server = 'sonar-server'
                    def ProjectKey = 'Go-Server'
                    staticCodeAnalysis(
                        credentialsId: SonarQube_Server,
                        projectKey: ProjectKey
                    )
                }
            }
        }
        stage('Quality Gate Status'){
            steps{
                script{
                    def SonarQube_Token = 'sonar-token'
                    qualityGateStatus(SonarQube_Token)
                }
            }
        }
        stage('DOCKER Image Build'){
            steps{
                script{
                    dockerBuild("${IMAGENAME}","${DOCKERHUB_USER}","${IMAGETAG}")
                }
            }
        }
        stage('DOCKER Image Scan: TRIVY'){
            steps{
                script{
                    dockerImageScan("${IMAGENAME}","${DOCKERHUB_USER}")
                }
            }
        }
        stage('DOCKER Image Push: Dockerhub'){
            steps{
                script{
                    def dockerCredId = 'docker'
                    dockerhubPush("${IMAGENAME}", "${DOCKERHUB_USER}", "${IMAGETAG}", dockerCredId)
                }
            }
        }
        stage('Triggering CD pipeline'){
            steps{
                script{
                    triggerJenkinsPipeline(
                        jenkinsUser: JENKINS_USER,
                        jenkinsUserToken: JENKINS_USER_TOKEN,
                        jenkinsIP: JENKINS_IP,
                        jenkinsPort: JENKINS_PORT,
                        jenkinsJob: JENKINS_CD_JOB_NAME,
                        jenkinsJobToken: JENKINS_CD_JOB_TOKEN,
                        imageTag: "${IMAGETAG}"
                    )
                }
            }
        }
    }
}