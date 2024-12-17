node {
  stage('Prepare') {
    echo "1.Prepare Stage"
    git credentialsId: 'github', url: 'https://github.com/soooldier/golang-ci-jenkins-pipeline.git'
    env.GIT_COMMIT_SHORT_HASH = sh (script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    env.BUILD_TAG = "${GIT_COMMIT_SHORT_HASH}.${BUILD_NUMBER}"
  }
  
  stage('Build') {
    echo "2.Build Docker Image Stage"
    sh 'go version'
    sh 'go mod download'
    sh 'go build main.go'
    sh 'docker build -t  ccr.ccs.tencentyun.com/enerlink/${JOB_NAME}:${BUILD_TAG} .'
  }
    
  stage('Push') {
    echo "3.Push Docker Image Stage"
    withCredentials([usernamePassword(credentialsId: 'ccr', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
      sh 'docker login ccr.ccs.tencentyun.com -u $USERNAME -p $PASSWORD'
    }
    sh 'docker push ccr.ccs.tencentyun.com/enerlink/${JOB_NAME}:${BUILD_TAG}'
  }
}
node('jenkins-slave-k8s-exec') {
  stage('Deploy') {
    input message: '请确认数据库、配置文件等前置操作是否完成！！！'
    sh "kubectl set image -n enerlink deployment.apps/demo jenkins-demo=${JOB_NAME}:${BUILD_TAG} --record=true"
  }
}
