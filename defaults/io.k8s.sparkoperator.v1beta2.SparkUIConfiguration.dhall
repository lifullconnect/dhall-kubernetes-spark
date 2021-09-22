let kubernetes = ../dependencies/kubernetes.dhall

in {
, servicePort = None Natural
, servicePortName = None Text
, serviceType = None kubernetes.ServiceSpec.Type
, serviceAnnotations = None (List { mapKey : Text, mapValue : Text })
, ingressAnnotations = None (List { mapKey : Text, mapValue : Text })
, ingressTLS = None (List kubernetes.IngressTLS.Type)
}