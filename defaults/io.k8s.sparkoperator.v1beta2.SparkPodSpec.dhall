let kubernetes = ../dependencies/kubernetes.dhall

in { 
, cores = None Natural
, coreLimit = None Text
, memory = None Text
, memoryOverhead = None Text
, gpu = None { name : Text, quantity : Natural }
, image = None Text
, configMaps = None (List { name : Text, path : Text })
, secrets = None (List { name : Text, path : Text, secretType : Text })
, env = None (List kubernetes.EnvVar.Type)
, envFrom = None (List kubernetes.EnvFromSource.Type)
, labels = None (List { mapKey : Text, mapValue : Text })
, annotations = None (List { mapKey : Text, mapValue : Text })
, volumeMounts = None (List kubernetes.VolumeMount.Type)
, affinity = None kubernetes.Affinity.Type
, tolerations = None (List kubernetes.Toleration.Type)
, podSecurityContext = None kubernetes.PodSecurityContext.Type
, securityContext = None kubernetes.SecurityContext.Type
, schedulerName = None Text
, sidecars = None (List kubernetes.Container.Type)
, initContainers = None (List kubernetes.Container.Type)
, hostNetwork = None Bool
, nodeSelector = None (List { mapKey : Text, mapValue : Text })
, dnsConfig = None kubernetes.PodDNSConfig.Type
, terminationGracePeriodSeconds = None Natural
, serviceAccount = None Text
, hostAliases = None (List kubernetes.HostAlias.Type)
, shareProcessNamespace = None Bool
}