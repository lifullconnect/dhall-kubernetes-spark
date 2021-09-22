let kubernetes = ../dependencies/kubernetes.dhall

in { 
, proxyUser = None Text
, image = None Text
, imagePullPolicy = None Text
, imagePullSecrets = None (List Text)
, mainClass = None Text
, mainApplicationFile = None Text
, arguments = None (List Text)
, sparkConf = None (List { mapKey : Text, mapValue : Text })
, hadoopConf = None (List { mapKey : Text, mapValue : Text })
, sparkConfigMap = None Text
, hadoopConfigMap = None Text
, volumes = None (List kubernetes.Volume.Type)
, deps = None ../types/io.k8s.sparkoperator.v1beta2.Dependencies.dhall
, restartPolicy = None ../types/io.k8s.sparkoperator.v1beta2.RestartPolicy.dhall
, failureRetries = None Natural
, retryInterval = None Natural
, pythonVersion = None Text
, memoryOverheadFactor = None Text
, monitoring = None ../types/io.k8s.sparkoperator.v1beta2.MonitoringSpec.dhall
, batchScheduler = None Text
, timeToLiveSeconds = None Natural
, batchSchedulerOptions = None ../types/io.k8s.sparkoperator.v1beta2.BatchSchedulerConfiguration.dhall
, sparkUIOptions = None ../types/io.k8s.sparkoperator.v1beta2.SparkUIConfiguration.dhall
, dynamicAllocation = None ../types/io.k8s.sparkoperator.v1beta2.DynamicAllocation.dhall
, template = None ../types/org.apache.airflow.2.0.2.AirflowTemplate.dhall
}