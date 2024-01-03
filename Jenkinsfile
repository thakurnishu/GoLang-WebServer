@Library('Jenkins-Shared-Lib') _

pipeline{
    agent any 

    parameters{
        choice(name: 'Action', choices: 'Create\nDestroy', description: "Choose Create\nDestroy")
    }

    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }

    stages{

        
        stage('Git Checkout'){
            when{ expression {
                params.Action == 'Create'
            } }
            steps{
                script{
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/thakurnishu/GoLang-WebServer.git"
                    )
                }
            }
        }

        stage('Unit Testing'){
            when{ expression {
                params.Action == 'Create'
            } }
            steps{
                script{
                    goTest()
                }
            }
        }

        stage('SonarQube Analysis'){
            when{ expression {
                params.Action == 'Create'
            } }
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
            when{ expression {
                params.Action == 'Create'
            } }
            steps{
                script{
                    def SonarQube_Token = 'sonar-token'
                    qualityGateStatus(SonarQube_Server)
                }
            }
        }

    }
}