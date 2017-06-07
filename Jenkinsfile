// vi: ft=groovy
// Scripted pipeline not Declarative (pipeline)
//
node ('Tropo-Operations_slv01'){
  // add timestamps to output
    stage('pull code') {
      // pull the code to the workspace
      checkout scm
       echo "My branch is: ${env.BRANCH_NAME}"
       sh ' echo in sh: $BRANCH_NAME'
       echo "The Build num: ${env.BUILD_NUMBER}"
    }
    stage('prebuild') {
      echo "Running the prebuild stage"
      echo "Checking syntax"
    }
    stage('build') {
      echo "Running the build stage"
        sh "build.sh ${env.BUILD_NUMBER}"
    }
    stage('test'){
      echo "Running the test stage"
        withCredentials([string(credentialsId: 'spark-pivot-authtoken', variable: 'spark-pivot-authtoken')]) {
          // some block
          sh "run.sh ${env.BUILD_NUMBER} $spark-pivot-authtoken "
        }
      }

    stage('archive'){
      echo "Running the archive stage"
    }
    stage('deploy'){
      echo "Running the deploy stage"
      if (currentBuild.result == 'SUCCESS') { // <1>
        echo "Build status and test status is good deploying "
      }
      else {
        echo "Current build status is unstable not deploying"
      }
    }
    stage('cleanup'){
      echo "Running the cleanup stage"
    }
  }
