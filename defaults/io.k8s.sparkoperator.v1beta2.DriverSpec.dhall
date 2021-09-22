let kubernetes = ../dependencies/kubernetes.dhall

in ./io.k8s.sparkoperator.v1beta2.SparkPodSpec.dhall /\ { 
, podName = None Text
, coreRequest = None Text
, javaOptions = None Text
, lifecycle = None kubernetes.Lifecycle.Type
, kubernetesMaster = None Text
, serviceAnnotations = None (List { mapKey : Text, mapValue : Text })
, ports = None (List { name : Text, protocol : Text, containerPort : Natural })
}