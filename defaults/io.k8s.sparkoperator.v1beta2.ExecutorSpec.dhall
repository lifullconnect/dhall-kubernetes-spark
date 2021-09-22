let kubernetes = ../dependencies/kubernetes.dhall

in ./io.k8s.sparkoperator.v1beta2.SparkPodSpec.dhall /\ { 
, instances = None Natural
, coreRequest = None Text
, javaOptions = None Text
, deleteOnTermination = None Bool
, ports = None (List { name : Text, protocol : Text, containerPort : Natural })
}