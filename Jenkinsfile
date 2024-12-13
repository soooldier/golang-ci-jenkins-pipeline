node {
    def root = tool name: 'Go1.21.9', type: 'go'
    ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/soooldier/golang-ci-jenkins-pipeline") {
        withEnv(["GOROOT=${root}/src", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/",
        "PATH+GO=${root}/bin"]) {
            env.PATH="${GOPATH}/bin:$PATH"

            stage 'Checkout'
            git url: 'https://github.com/soooldier/golang-ci-jenkins-pipeline.git'

            stage 'Build'
            sh 'go version'
            sh 'go mod download'
            sh 'go build .'
            
            stage 'Deploy'
            // Do nothing.
        }
    }
}
