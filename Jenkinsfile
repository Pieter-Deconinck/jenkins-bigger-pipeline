node {
    checkout([
        $class: 'GitSCM', 
        branches: [[name: '*/main']], 
        doGenerateSubmoduleConfigurations: false, 
        extensions: [], 
        submoduleCfg: [], 
        userRemoteConfigs: [[url: 'https://github.com/Pieter-Deconinck/jenkins-bigger-pipeline']]
    ])
    checkout([
        $class: 'GitSCM', 
        branches: [[name: '*/master']], 
        doGenerateSubmoduleConfigurations: false, 
        extensions: [[
            $class: 'SparseCheckoutPaths',
            paths: ['app/']
        ]], 
        submoduleCfg: [], 
        userRemoteConfigs: [[url: 'https://github.com/Pieter-Deconinck/getting-started']]
    ])

    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop mysqltodo'
            sh 'docker rm mysqltodo'
            sh 'docker stop todoapp'
            sh 'docker rm todoapp'
        }
    }
    stage('Build') {
        build 'buildSqlContainer'
    }
    stage('Results') {
        build 'buildTodoContainer'
    }
}