let kubernetes = ../dependencies/kubernetes.dhall

in ./io.k8s.sparkoperator.v1beta2.SparkPodSpec.dhall //\\ { 
, instances : Optional Natural
, coreRequest : Optional Text
, javaOptions : Optional Text
, deleteOnTermination : Optional Bool
, ports : Optional (List { name : Text, protocol : Text, containerPort : Natural })
}