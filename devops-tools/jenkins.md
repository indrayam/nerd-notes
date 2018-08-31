### jenkins

To interact with Jenkins CLI, download the jar file:

```bash
curl -L -O https://ci6.cisco.com/jnlpJars/jenkins-cli.jar
```

Use help command. For example:

```bash
java -jar jenkins-cli.jar -s https://ci6.cisco.com -auth anasharm:fd42059e120bf3de8d1d61894580a774 help console
```

Manual changes after a typical Jenkins install:

1. Go to `http://IP:8080`
2. Enter secret to get inside Jenkins UI
3. Install selected plugins
4. Create an Admin user
5. Update _Manage Jenkins > Global Tool Configurations_
       Configure JDK, Maven
6. Add the following plugins after you are in:
      - Unleash Maven
      - Docker Build and Publish
      - GitHub Integration Plugin
      - Blue Ocean Aggregator
      - BitBucket
7. Make sure the Load Balancer's HealthCheck URL is: http://<ip>:8080/login (OPTIONAL)
8. Change the docker daemon on the CI server to listen on port 2375 by changing the file: `/lib/systemd/system/docker.service`

```bash
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://localhost:2375

sudo systemctl daemon-reload
sudo systemctl stop docker 
sudo systemctl start docker
```

