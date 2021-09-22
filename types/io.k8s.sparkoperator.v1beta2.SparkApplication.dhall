let kubernetes = ../dependencies/kubernetes.dhall

in { apiVersion : Text
, kind : Text
, metadata : kubernetes.ObjectMeta.Type
, spec : ./io.k8s.sparkoperator.v1beta2.SparkApplicationSpec.dhall
, status : Optional ./io.k8s.sparkoperator.v1beta2.SparkApplicationStatus.dhall
}