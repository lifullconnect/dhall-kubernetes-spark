let kubernetes = ../dependencies/kubernetes.dhall

in { 
, type : Text
, sparkVersion : Text
, mode : Text
, proxyUser : Optional Text
, image : Optional Text
, imagePullPolicy : Optional Text
, imagePullSecrets : Optional (List Text)
, mainClass : Optional Text
, mainApplicationFile : Optional Text
, arguments : Optional (List Text)
, sparkConf : Optional (List { mapKey : Text, mapValue : Text })
, hadoopConf : Optional (List { mapKey : Text, mapValue : Text })
, sparkConfigMap : Optional Text
, hadoopConfigMap : Optional Text
, volumes : Optional (List kubernetes.Volume.Type)
, driver : ./io.k8s.sparkoperator.v1beta2.DriverSpec.dhall
, executor : ./io.k8s.sparkoperator.v1beta2.ExecutorSpec.dhall
, deps : Optional ./io.k8s.sparkoperator.v1beta2.Dependencies.dhall
, restartPolicy : Optional ./io.k8s.sparkoperator.v1beta2.RestartPolicy.dhall
, failureRetries : Optional Natural
, retryInterval : Optional Natural
, pythonVersion : Optional Text
, memoryOverheadFactor : Optional Text
, monitoring : Optional ./io.k8s.sparkoperator.v1beta2.MonitoringSpec.dhall
, batchScheduler : Optional Text
, timeToLiveSeconds : Optional Natural
, batchSchedulerOptions : Optional ./io.k8s.sparkoperator.v1beta2.BatchSchedulerConfiguration.dhall
, sparkUIOptions : Optional ./io.k8s.sparkoperator.v1beta2.SparkUIConfiguration.dhall
, dynamicAllocation : Optional ./io.k8s.sparkoperator.v1beta2.DynamicAllocation.dhall
, template : Optional ./org.apache.airflow.2.0.2.AirflowTemplate.dhall
}