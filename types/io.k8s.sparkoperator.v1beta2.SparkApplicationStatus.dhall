let kubernetesTime = ../dependencies/kubernetes.time.dhall

in { 
, sparkApplicationId : Text
, submissionID : Text
, lastSubmissionAttemptTime : kubernetesTime
, terminationTime : kubernetesTime
, driverInfo : ./io.k8s.sparkoperator.v1beta2.DriverInfo.dhall
, applicationState : ./io.k8s.sparkoperator.v1beta2.ApplicationState.dhall
, executorState : List { mapKey : Text, mapValue : Text }
, executionAttempts : Natural
, submissionAttempts : Natural
}