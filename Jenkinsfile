@Library('')

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

    }
}