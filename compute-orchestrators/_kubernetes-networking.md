# Kubernetes Networking Notes

### Designing and Preparing to setup the networking aspects of K8S Cluster

Kubernetes allocates an IP address to **each pod**. When creating a cluster, you need to allocate a block of IPs for Kubernetes to use as Pod IPs. The simplest approach is to allocate *a different block of IPs* to each node in the cluster as the node is added. A process in one pod should be able to communicate with another pod using the IP of the second pod. 

This connectivity can be accomplished in two ways:

- **Using an overlay network:** An overlay network obscures the underlying network architecture from the pod network through traffic encapsulation (for example vxlan)
- **Without an overlay network:** Configure the underlying network fabric (switches, routers, etc.) to be aware of pod IP addresses. This does not require the encapsulation provided by an overlay, and so can achieve better performance.

You will need to select an address range for the Pod IPs. Note that IPv6 is not yet supported for Pod IPs. We have two choices here:

- Allocate one CIDR subnet for each node’s Pod IPs, or
- A single large CIDR from which smaller CIDRs are automatically allocated to each node.

The latter is a more common way to go about giving each Pod an IP. How many total PoD IPs does one need? You need `max-number-of-nodes * max-pods-per-node` total IPs. 

- A `/24` per subnet for the Kuberntes cluster supports 254 virtual machines (or nodes) per subnet for Control Plane and Workers. Let's say we use **9** IP addresses for the Kubernetes Control Plane nodes. That leaves **245** IP addresses for Worker node. A `/24` per node supports **254** pods per machine and is a common choice. That would mean this particular subnet would be able to run a grand total of **245 * 254 = 62230** Pods in this cluster! If IPs are scarce, a /26 (62 pods per machine) or even a /27 (30 pods) may be sufficient.
- For example, use `10.10.0.0/16` as the range for the cluster. This will support 256 subnets. Translation, you can configure the 256 nodes using `10.10.0.0/24` through `10.10.255.0/24` subnets respectively.
- Need to make these routable or connect with overlay.

Kubernetes also allocates an IP to each service. However, service IPs do not necessarily need to be routable. The kube-proxy takes care of translating Service IPs to Pod IPs before traffic leaves the node. You do need to allocate a block of IPs for services. Call this SERVICE_CLUSTER_IP_RANGE. For example, you could set SERVICE_CLUSTER_IP_RANGE="10.0.0.0/16", allowing 65534 distinct services to be active at once. Note that you can grow the end of this range, but you cannot move it without disrupting the services and pods that already use it.

Also, you need to pick a static IP for master node. Call this MASTER_IP. Open any firewalls to allow access to the apiserver ports 80 and/or 443. Enable ipv4 forwarding sysctl, net.ipv4.ip_forward = 1

### K8S Networking Model

There are 4 distinct networking problems to solve:

- Highly-coupled container-to-container communications: this is solved by pods and localhost communications.
- Pod-to-Pod communications
- Pod-to-Service communications
- External-to-Service communications

Kubernetes assumes that pods can communicate with other pods, regardless of which host they land on. Every pod gets its own IP address so you do not need to explicitly create links between pods and you almost never need to deal with mapping container ports to host ports. This creates a clean, backwards-compatible model where pods can be treated much like VMs or physical hosts from the perspectives of port allocation, naming, service discovery, load balancing, application configuration, and migration.

Kubernetes imposes the following fundamental requirements on any networking implementation to achieve this:

- all containers can communicate with all other containers without NAT
- all nodes can communicate with all containers (and vice-versa) without NAT
- the IP that a container sees itself as is the same IP that others see it as

This model is not only less complex overall, but it is principally compatible with the desire for Kubernetes to enable low-friction porting of apps from VMs to containers. If your job previously ran in a VM, your VM had an IP and could talk to other VMs in your project. This is the same basic model.

Until now this document has talked about containers. In reality, Kubernetes applies IP addresses at the `Pod` scope - containers within a Pod share their network namespaces - including their IP address. This means that containers within a Pod can all reach each other’s ports on localhost. This does imply that containers within a Pod must coordinate port usage, but this is no different than processes in a VM. This is called the **“IP-per-pod”** model. This is implemented in Docker as a “pod container” (called *pause*) which holds the network namespace open while “app containers” (the things the user specified) join that namespace with Docker’s --net=container:<id> function.

As with Docker, it is possible to request host ports, but this is reduced to a very niche operation. In this case a port will be allocated on the host Node and traffic will be forwarded to the Pod. The Pod itself is blind to the existence or non-existence of host ports.


