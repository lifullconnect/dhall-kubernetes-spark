let kubernetes = ../dependencies/kubernetes.dhall

in {
, servicePort : Optional Natural
, servicePortName : Optional Text
, serviceType : Optional kubernetes.ServiceSpec.Type
, serviceAnnotations : Optional (List { mapKey : Text, mapValue : Text })
, ingressAnnotations : Optional (List { mapKey : Text, mapValue : Text })
, ingressTLS : Optional (List kubernetes.IngressTLS.Type)
}