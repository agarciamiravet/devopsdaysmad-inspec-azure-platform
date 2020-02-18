pipeline {
         agent any
          environment {
               AZURE_SUBSCRIPTION_ID = credentials('jenkins-arm-subscription-id')
               AZURE_CLIENT_ID = credentials('jenkins-arm-client-id')
               AZURE_TENANT_ID = credentials('jenkins-arm-tenant-id')
               AZURE_CLIENT_SECRET = credentials('jenkins-arm-client-secret')
         }
         stages 
         {            
                 stage ('Inspec Azure Platform Tests') {
                   steps {

                        withCredentials([file(credentialsId: 'azureattributes', variable: 'azureattributes')]) {
                              dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-inspec-azure-platform"){         
                                 sh'inspec exec . --chef-license=accept --input-file $azureattributes --reporter cli junit:testresults.xml json:output.json --no-create-lockfile  -t azure://'
                              }
                        }                                                                                                    
                   }
                 }

                  stage('Upload Azure Platform Tests to Grafana') {
                        steps {
                             dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-inspec-azure-platform"){                                   
                                   sh '''
                                        ls
                                        curl -F 'file=@output.json' -F 'platform=azure-platform' http://localhost:5001/api/InspecResults/Upload
                                   '''                                   
                           }                      
                        }
                    }

                 }
                 post {
                         always {
                                junit '**/src/inspec/devopsdaysmad-inspec-azure-platform/*.xml'
                             }
                 }
          }
