pipeline {
    agent {
        label 'docker-agent-maven'
    }
    triggers {
        pollSCM '*/5 * * * *'
      } 
      
    stages {
        stage('Build') {
            steps {
                echo 'Building....'
                sh '''
                cd demo
                mvn -B -DskipTests clean package
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd demo
                mvn --version
                mvn test
                '''
            }
        }
        stage('Build image'){
            steps{
                echo 'bulding docker image'
                sh ''' 
                docker build -t sprysio/backend_build:${BUILD_ID} .
                docker tag sprysio/backend_build:${BUILD_ID} sprysio/backend_build:latest
                '''
            }
        }
        stage('Push dockerhub')
        {
            steps{
                echo 'pushing to dockerhub'
                withCredentials([usernamePassword(credentialsId: 'fbc65aa1-fe5a-4e2d-89c8-ec8fe49c1180', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                sh '''
                docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                docker push sprysio/backend_build:${BUILD_ID} 
                docker push sprysio/backend_build:latest
                '''
            }
            }
        }
    }
    post{
        always {  
             echo 'This will always run'  
         }  
         success {  
             echo 'This will run only if successful'  
         }  
         failure {  
            echo 'This will run only if failure'  
             //mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "sebastianfors123@tutanota.com";  
         }  
         unstable {  
             echo 'This will run only if the run was marked as unstable'  
         }  
         changed {  
             echo 'This will run only if the state of the Pipeline has changed'  
             echo 'For example, if the Pipeline was previously failing but is now successful'  
         }
      }
}