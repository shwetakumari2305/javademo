node {
    stage('SCM checkout') {
        git branch: 'main', url: 'https://github.com/shwetakumari2305/javademo.git'
    }
    
    stage('Mvn Package') {
        def mvnHome = tool name: 'maven1', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
    }
    
    stage('Build Docker Image') {
        sh 'docker build -t shwetashukla23/javademo:latest .'
    }
    
    stage('Push Docker Image') {
        withCredentials([string(credentialsId: 'dockerhub_password1', variable: 'dockerhubpwd')]) {
            sh "docker login -u shwetashukla23 -p ${dockerhubpwd}"
        }
        sh 'docker push shwetashukla23/javademo:latest'
    }
    
    stage('Remove Old Container') {
        sh 'if docker ps -a --format "{{.Names}}" | grep -i "^javademo$"; then \
                docker stop javademo; \
                docker rm -f javademo; \
            fi'
        sh 'if docker images --format "{{.Repository}}:{{.Tag}}" | grep -i "^shwetashukla23/javademo:latest$"; then \
                docker rmi -f shwetashukla23/javademo:latest; \
            fi'
    }
    
    stage('Run Docker Image') {
        sh 'docker run -d -p 80:8080 --name javademo shwetashukla23/javademo:latest'
    }
    stage('k8s deployment') {
    sshagent(['k8sMaster']) {
          sh "ssh -o StrictHostKeyChecking=no -l ec2-user 172.31.23.244 kubectl create deployment sms --image=shwetashukla23/javademo:latest --replicas=1 --port=8080 "
          sh 'ssh -o StrictHostKeyChecking=no -l ec2-user 172.31.23.244 kubectl expose deployment sms --type=NodePort --name=smssvc --port=8080 --target-port=8080 '
    }
  }
}
