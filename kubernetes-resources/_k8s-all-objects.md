# Kubernetes Resources

### Resource Categories

This is a high-level overview of the basic types of resources provide by the Kubernetes API and their primary functions.

- **Workload Resources (8)** are objects you use to manage and run your containers on the cluster
    + Pod
    + ReplicationController
    + ReplicaSet
    + Deployment
    + Job
    + CronJob
    + DaemonSet
    + StatefulSet
- **Discovery & LB Resources (3)** are objects you use to "stitch" your workloads together into an externally accessible, load-balanced Service
    + Service
    + Endpoints
    + Ingress
- **Config & Storage Resources (4)** are objects you use to inject initialization data into your applications, and to persist data that is external to your container
    + ConfigMap
    + Secrets
    + PersistentVolumeClaim
    + StorageClass
- **Cluster Resources (12)** are objects that define how the cluster itself is configured; these are typically used only by cluster operators
    + Namespace
    + Node
    + ComponentStatus
    + PersistentVolume
    + ServiceAccount
    + Role
    + RoleBinding
    + ClusterRole
    + ClusterRoleBinding
    + NetworkPolicy
    + ResourceQuota
    + CertificateSigningRequest
- **Metadata Resources (6)** are objects you use to configure the behavior of other resources within the cluster, such as HorizontalPodAutoscaler for scaling workloads
    + Event
    + CustomResourceDefinition
    + LimitRange
    + HorizontalPodAutoscaler
    + PodSecurityPolicy
    + PodDisruptionBudget

### Resource Objects

Resource objects typically have 3 components:

- **Resource ObjectMeta:** This is metadata about the resource, such as its name, type, api version, annotations, and labels. This contains fields that maybe updated both by the end user and the system (e.g. annotations)
- **ResourceSpec:** This is defined by the user and describes the desired state of system. Fill this in when creating or updating an object.
- **ResourceStatus:** This is filled in by the server and reports the current state of the system. Only kubernetes components should fill this in





