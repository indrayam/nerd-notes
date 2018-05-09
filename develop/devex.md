Developer Experience:
- Non-Containerized App Deployment to Gen2 VMs (or LAE) involves the following steps:
 
- Containerized App Deployment into Kubernetes Cluster involves the following steps:
    + Write Code
    + Compile and Run Unit Tests locally
    + Perform Basic Functional Tests locally
    + Create Dockerfile, most likely by searching Google/StackOverflow and doing Copy-n-Paste
    + Build Docker Image with appropriate tags and labels
    + Push Docker Image
    + Create Kubernetes YAML-based App Manifest(s), most likely by searching Google/StackOverflow and doing Copy-n-Paste
    + Kubectl Apply
- When you have to make code changes, the cycle looks like
    + Make Code Changes
    + Compile and Run Unit Tests locally
    + Perform Basic Functional Tests locally
    + Edit Dockerfile, if necessary. Usually not.
    + Build Docker Image with appropriate tags and labels
    + Push Docker Image
    + Edit Kubernetes YAML-based App Manifest(s) to reflect changes to Container Image tags
    + Kubectl Apply
- If we do nothing (keep CD 1.0 as-is), the flow would look like
