## Pragmatic Practices to Build Modern Containerized Apps Running on Kubernetes

### Java, Go, Python Development:

- For Java software, use JDK 9 or above [Java inside docker: What you must know to not FAIL](https://developers.redhat.com/blog/2017/03/14/java-inside-docker/), [Running Java in a Container](https://mesosphere.com/blog/java-container/)

### Packaging Apps in Containers:

- Build small and secure Container images for Performance and Security Reasons (Small base images and Builder Pattern)
- Use JDK 9 and above to ensure memory and compute settings are actually honored

### Kubernetes Configurations:

- Use Service Discovery built into Kubernetes. NO calls using hardcoded IP address allowed
- Add _labels_ to every Kubernetes Resource that you create (sw=,env=,dev=,...)
- Use Downward API, take metadata about the cluster and slap it onto the container inside a Pod
- Use _matchLabels:_ as Selector
- Always clearly specify rollout behavior in Deployments (like _RollingUpdate_)
- Use _ConfigMap_ and _Secrets_ as Volumes or Env variables. Use _ConfigMap_ to provide config files to a service or content to an app
- Use Affinity (_podAffinity_, _podAntiAffinity_) Rules (Scheduler Feature) to show how Pods relate to each other
- Set _terminationGracePeriodSeconds: 60_ to give containers extra time to term gracefully
- Add SecurityContext to Pod and/or Container level (_Read Only_, _Root Allowed_, _Root Capabilities_, _Run User_, _Privileged_)
- Always add _readinessProbe_ and _livenessProbe_ to avoid premature load shift and fix hung processes. Stick with HTTP probes, unless there is a Command probe that might give better results. Do not forget to set the _initialDelaySeconds_ value for Liveness probes otherwise you will end up in an infinite loop. Coming up with good quality probes is a [non-trivial problem](https://medium.com/@copyconstruct/health-checks-in-distributed-systems-aa8a0e8c1672)
- Use lifecycle (_preStop_, _postStart_, etc.) to inject functionality at runtime

### References:

- [GCP: Kubernetes Best Practices](https://www.youtube.com/playlist?list=PLIivdWyY5sqL3xfXz5xJvwzFW_tlQB_GB)
