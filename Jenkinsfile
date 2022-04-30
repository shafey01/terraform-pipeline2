pipeline {

    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }

    stages {

        stage('build infrastructure'){

            steps{
                slackSend color: "#99ff66", message: "start build"
               
            }
        }


        stage('plan terraform on dev enviroment'){
            

            steps{
                slackSend color: "#66ff99", message: "start terraform plan on dev enviroment"
                sh "terraform init -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' "
                 sh "terraform plan  -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY'  "
            }
        }

        stage('terraform apply on dev enviroment'){

           
            steps{
                slackSend color: "#66ff99", message: "start terraform apply on dev enviroment"
              sh "terraform apply -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' -auto-approve "
            }
        }

        stage('ansible install node exporter'){

             environment {
                 SSH_KEY = credentials('SSH_KEY')
               
           }


            steps{
                slackSend color: "#66ff99", message: "install node exporter"
                 sh "ansible-playbook --private-key $SSH_KEY  ./ansible/node-playbook -vv"
            }
        }
        
    

    }
    post { 
            success { 
                slackSend color: "good", message: "infrastructure pipeline succesed"

            }

            


        }

}