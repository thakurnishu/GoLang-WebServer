@Library('Jenkins-Shared-Lib') _

pipeline{
    agent any 

    stages{

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

        stage('Unit Testing'){
            steps{
                script{
                    goTest()
                }
            }
        }

    }
}