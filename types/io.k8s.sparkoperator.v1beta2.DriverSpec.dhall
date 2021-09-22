let kubernetes = ../dependencies/kubernetes.dhall

in ./io.k8s.sparkoperator.v1beta2.SparkPodSpec.dhall //\\ { 
, podName : Optional Text
, coreRequest : Optional Text
, javaOptions : Optional Text
, lifecycle : Optional kubernetes.Lifecycle.Type
, kubernetesMaster : Optional Text
, serviceAnnotations : Optional (List { mapKey : Text, mapValue : Text })
, ports : Optional (List { name : Text, protocol : Text, containerPort : Natural })
}