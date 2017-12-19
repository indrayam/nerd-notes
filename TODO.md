# TODO
This file contains a list of the following things I would like to work on. Things that I have figured out will be marked with a ~~strikethough~~

### Infrastructure-as-a-Service

**Compute**
1. ~~Create VMs using Ubuntu, CentOS images~~ (~~DO~~, ~~GCP~~, AWS, AZ)
2. ~~Set it up as “Dev” machine~~ (~~DO~~, ~~GCP~~, AWS, AZ)
3. ~~Create Snapshot~~ (~~DO~~, GCP, AWS, AZ)
4. Recreate Droplets using Snapshot
5. Delete the Droplet

**Network**
1. Assign DNS CNAME entries to created VMs
2. Load Balancer with Let’s Encrypt certificate for the LB
3. Private IP/Network
4. Floating IP
5. Firewalls
6. PTR records
7. Global Load Balancer
8. CDN

**Storage**
1. Block Storage
2. S3/Spaces

**Apps**
1. Install web server with firewall
2. Let’s Encrypt certificate for Nginx (without LB)
3. App
4. Database
5. Message Queues
6. Workers

### Containers-as-a-Service

**Setup Kubernetes Cluster**
1. ...

**Cloud Native Apps**
1. Design a Cloud Native Application with 3 Microservices: 1 web front-end Microservice and 2 API Microservices
2. Write all 3 in Java OR Write front-end in Java, one API in Go and the other API in Python
3. Build a Container Image for each of the Microservice
4. Deploy each image to Google Container Registry OR DockerHub or Azure Container Registry
    
### Platform-as-a-Service
Coming soon...

### Functions-as-a-Service
Coming soon...

### Software-as-a-Service
**Developer Tools**
1. Git
2. Continuous Integration
3. Continuous Deployment
4. Configuration Management

### Miscellaneous Items
**Tmux/SSH**
1. If I remotely log into an Ubuntu machine over SSH from my MacOS directly into a tmux session, I cannot seem to figure out a way to copy my selections into the Mac's system clipboard. It copies into Tmux "clipboard"
2. Play with tmux.conf that is simpler than "Oh-my-Tmux"
