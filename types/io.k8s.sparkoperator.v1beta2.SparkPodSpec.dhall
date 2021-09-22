let kubernetes = ../dependencies/kubernetes.dhall

in { 
, cores : Optional Natural
, coreLimit : Optional Text
, memory : Optional Text
, memoryOverhead : Optional Text
, gpu : Optional { name : Text, quantity : Natural }
, image : Optional Text
, configMaps : Optional (List { name : Text, path : Text })
, secrets : Optional (List { name : Text, path : Text, secretType : Text })
, env : Optional (List kubernetes.EnvVar.Type)
, envFrom : Optional (List kubernetes.EnvFromSource.Type)
, labels : Optional (List { mapKey : Text, mapValue : Text })
, annotations : Optional (List { mapKey : Text, mapValue : Text })
, volumeMounts : Optional (List kubernetes.VolumeMount.Type)
, affinity : Optional kubernetes.Affinity.Type
, tolerations : Optional (List kubernetes.Toleration.Type)
, podSecurityContext : Optional kubernetes.PodSecurityContext.Type
, securityContext : Optional kubernetes.SecurityContext.Type
, schedulerName : Optional Text
, sidecars : Optional (List kubernetes.Container.Type)
, initContainers : Optional (List kubernetes.Container.Type)
, hostNetwork : Optional Bool
, nodeSelector : Optional (List { mapKey : Text, mapValue : Text })
, dnsConfig : Optional kubernetes.PodDNSConfig.Type
, terminationGracePeriodSeconds : Optional Natural
, serviceAccount : Optional Text
, hostAliases : Optional (List kubernetes.HostAlias.Type)
, shareProcessNamespace : Optional Bool
}