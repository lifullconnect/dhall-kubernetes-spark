{-
    Usage:

    dhall-to-yaml-ng --explain <<< ./examples/deploymentExample.dhall
-}

let kubernetes = ../dependencies/kubernetes.dhall

let spark = ../package.dhall

let labels = toMap { 
    , version = "3.1.1"
    , metrics = "prometheus"
}

let podSecurityContext = kubernetes.PodSecurityContext::{
    , fsGroup = Some 185 
}

let sparkLogsVolumeMount = kubernetes.VolumeMount::{
    , name = "spark-logs"
    , mountPath = "/tmp/spark-logs"
    , readOnly = Some False
}

let fluentBitVolumeMount = kubernetes.VolumeMount::{
    , name = "fluent-bit"
    , mountPath = "/tmp/fluent-bit"
    , readOnly = Some False
}

let fluentBitResourcesLimits = toMap {
    , cpu = "50m"
    , memory = "60Mi"
}

let fluentBitResourcesRequests = toMap {
    , cpu = "5m"
    , memory = "10Mi"
}

let fluentBitSidecar = kubernetes.Container::{
    , name = "fluent-bit"
    , image = Some "fluent/fluent-bit:1.7"
    , command = Some [ "/fluent-bit/bin/fluent-bit", "-c", "/tmp/fluent-bit/fluent-bit-custom.conf" ]
    , resources = Some kubernetes.ResourceRequirements::{
        , limits = Some fluentBitResourcesLimits
        , requests = Some fluentBitResourcesRequests
    }
    , volumeMounts = Some [ sparkLogsVolumeMount, fluentBitVolumeMount ]
}

let driverSpec = spark.DriverSpec::{
    , cores = Some 1
    , coreLimit = Some "1200m"
    , memory = Some "512m"
    , labels = Some labels
    , serviceAccount = Some "fargate"
    , podSecurityContext = Some podSecurityContext
    , volumeMounts = Some [ sparkLogsVolumeMount, fluentBitVolumeMount ]
    , sidecars = Some [ fluentBitSidecar ]
}

let executorSpec = spark.ExecutorSpec::{
    , cores = Some 1
    , instances = Some 3
    , memory = Some "512m"
    , labels = Some labels
    , serviceAccount = Some "fargate"
    , podSecurityContext = Some podSecurityContext
    , volumeMounts = Some [ sparkLogsVolumeMount, fluentBitVolumeMount ]
    , sidecars = Some [ fluentBitSidecar ]
}

let volumes = [
    , kubernetes.Volume::{
        , name = "spark-logs"
        , emptyDir = Some kubernetes.EmptyDirVolumeSource::{
            , medium = None Text
        }
    }
    , kubernetes.Volume::{
        , name = "fluent-bit"
        , configMap = Some kubernetes.ConfigMapVolumeSource::{
            , name = Some "fluent-bit-conf-map"
        }
    }
]

let monitoring = spark.MonitoringSpec::{
    , exposeDriverMetrics = True
    , exposeExecutorMetrics = True
    , prometheus = Some spark.PrometheusSpec::{
        , jmxExporterJar = "/opt/spark/jars/jmx_prometheus_javaagent-0.15.0.jar"
        , port = Some 8090
        , configuration = Some ""
    }
}

let sparkApplicationSpec = spark.SparkApplicationSpec::{
    , type = "Scala"
    , sparkVersion = "3.1.1"
    , mode = "cluster"
    , driver = driverSpec
    , executor = executorSpec
    , deps = Some spark.Dependencies::{
        , files = Some [ "local:///etc/spark/conf/default-logstash-fields.properties" ]
    }
    , sparkConfigMap = Some "spark-conf-map-{PIPELINE_NAME}-{APPLICATION_NAME}"
    , sparkConf = Some [ 
        , { mapKey = "spark.eventLog.enabled", mapValue = "true" } 
        , { mapKey = "spark.eventLog.dir", mapValue = "s3a://{ARTIFACTS_S3_BUCKET}/spark-events" } 
        , { mapKey = "spark.eventLog.rolling.enabled", mapValue = "true" }
        , { mapKey = "spark.eventLog.rolling.maxFileSize", mapValue = "128m" }
        , { mapKey = "spark.metrics.namespace", mapValue = "{PIPELINE_NAME}-{APPLICATION_NAME}" }
        , { mapKey = "spark.executor.processTreeMetrics.enabled", mapValue = "true" }
    ]
    , hadoopConf = Some [
        , { mapKey = "fs.s3a.aws.credentials.provider", mapValue = "com.amazonaws.auth.WebIdentityTokenCredentialsProvider" } 
    ]
    , image = Some "{DOCKER_REPOSITORY}.amazonaws.com/spark:3.1.1-v1.0.3"
    , imagePullPolicy = Some "IfNotPresent"
    , mainClass = Some "com.lifullconnect.sem.test.App"
    , arguments = Some [ "days-to-process=3" ]
    , mainApplicationFile = Some "s3a://{ARTIFACTS_S3_BUCKET}/sem-test-application-assembly.jar"
    , restartPolicy = Some spark.RestartPolicy::{
        , type = "Never"
    }
    , volumes = Some volumes
    , monitoring = Some monitoring
    , template = Some {
        , metadata = {
            , labels = {
                , app = "test-app-pod"
            }
        }
    }
}

in spark.SparkApplication::{
    , metadata = kubernetes.ObjectMeta::{
        , name = Some "test-application"
        , namespace = Some "fargate"
    }
    , spec = sparkApplicationSpec
}