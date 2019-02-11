# jenkins


## Install Jenkins

- Use `jenkins.sh` userdata script to instantiate a VM to act as Jenkins master. It comes with Nginx and Jenkins pre-installed
- Use `devzone.sh` userdata script to instantiate a VM to act as Jenkins node. It comes with tools like `java`, `maven`, `gradle`, `git`, `go` and `docker` installed
- Install/Upgrade git:

```bash
sudo apt-get install build-essential autoconf zlib1g-dev tcl tcl-dev gettext
curl -L -O https://github.com/git/git/archive/v2.18.0.tar.gz
tar -xvzf v2.18.0.tar.gz
cd git-2.18.0
make configure
./configure --prefix=/usr/local
make all
sudo make install

# Check version
exit
git --version
```
- Change the docker daemon to listen on port 2375 by changing the file: `/lib/systemd/system/docker.service`

```bash
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://localhost:2375

sudo systemctl daemon-reload
sudo systemctl stop docker 
sudo usermod -a -G docker jenkins ubuntu
sudo systemctl start docker
```

- Create two Nginx conf files in /etc/nginx/conf.d: `default.conf` and `jenkins1-code.conf`
- Here is what `default.conf` should look like:

```
# Default server configuration

server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name jenkins1-code.cisco.com;
    #return 301 https://$server_name$request_uri;

  proxy_set_header HOST $host;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

  location / {
    proxy_pass http://127.0.0.1:8080;
  }
}
```

- Here is what `jenkins1-code.conf` should like:

```
# Virtual Host configuration for example.com
#
server {
  listen 443 ssl;
  ssl_certificate /etc/nginx/ssl/jenkins1-code.cisco.com.crt;
  ssl_certificate_key /etc/nginx/ssl/jenkins1-code.cisco.com.key;

  server_name jenkins1-code.cisco.com;

  proxy_set_header HOST $host;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

  location / {
    proxy_pass http://127.0.0.1:8080;
  }
}
```

- Create self-signed certificate for `jenkins1-code.conf` in `~/src/certs`. Reference: [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)
    + `openssl genrsa -out ca.key 4096`
    + `openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt`
    + `openssl genrsa -out jenkins1-code.cisco.com.key 4096`
    + Create CSR:

```
    openssl req -new -sha256 \
    -key jenkins1-code.cisco.com.key \
    -subj "/C=US/ST=NC/O=CoDE, Inc./CN=jenkins1-code.cisco.com" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:jenkins1-code.cisco.com")) \
    -out jenkins1-code.cisco.com.csr
```
- Generate Certificate using the CSR:

```bash
openssl x509 -req -sha256 \
    -in jenkins1-code.cisco.com.csr \
    -CA ca.crt \
    -CAkey ca.key \
    -CAcreateserial \
    -out jenkins1-code.cisco.com.crt \
    -extensions SAN \
    -extfile <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:jenkins1-code.cisco.com")) \
    -days 500
```

- Import the certificate into your MacOS (OPTIONAL)
- Restart Nginx
- Open Chrome and go to `jenkins1-code.cisco.com`
- Get content from `/var/lib/jenkins/secrets/initialAdminPassword` and enter it to start administering Jenkins
- Install Recommended Plugins
- Make sure the following plugins are installed/updated:
    + Unleash Maven
    + CloudBees Docker Build and Publish
    + Active Directory
    + GitHub Integration Plugin (OPTIONAL)
    + Blue Ocean Aggregator
    + SonarQube Scanner for Jenkins - 2.6.1
    + Artifactory - 2.15.1
    + Bitbucket - This one has config changes, but impact should be small, since it is unlikely anyone is using it - 2.2.9
    + Pipeline - The following should get installed by default
        + Pipeline: API - 2.2.7
        + Pipeline: Basic Steps - 2.6
        + Pipeline: Build Step - 2.7
        + Pipeline: Declarative - 1.2.9
        + Pipeline: Declarative Extension Points API - 1.2.9
        + Pipeline: Groovy - 2.46
        + Pipeline: Job - 2.17
        + Pipeline: Milestone Step - 1.3.1
        + Pipeline: Model API - 1.2.9
        + Pipeline: Multibranch - 2.17
        + Pipeline: Nodes and Processes - 2.19
        + Pipeline: REST API Plugin - 2.9
        + Pipeline: SCM Step - 2.6
        + Pipeline: Shared Groovy Libraries - 2.9
        + Pipeline: Stage Step - 2.3
        + Pipeline: Stage Tags Metadata - 1.2.9
        + Pipeline: Stage View Plugin - 2.9
        + Pipeline: Step API - 2.16
        + Pipeline: Supporting APIs - 2.18
    + Pipeline: Utility Steps - 2.0.2 - New plugin
- Install CDA Build Activity Plugin
    + Get it from Google Cloud Storage 
    + sftp the file to the Jenkins server. In the folder `/var/lib/jenkins/plugins`
    + Make sure the ownership of the file is set to the userid used by `jenkins`. In Ubuntu, the UID was `jenkins`
- Configure `Manage Jenkins > Configure Global Security`. Enable Security. Select `Active Directory` and enter the following data:
    + `Domain Name:` **cisco.com**
    + `Domain Controller:` **ds.cisco.com:3268**
    + `Bind DN:` **CN=dft-ds.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com**
    + `Bind Password:` ...
    + `TLS Configuration:` **Trust all certificates**
    + Click `Test Domain` and make sure it returns Success
    + Click on `Advanced`
    + Group Membership Lookup Strategy: Change from "Automatic" to **"Recursive Group Queries"**
- Configure `Authorization`. Select `Project-based Matrix Authorization`. Make sure `Anonymous Users` and `Authenticated Users` have `Administer` checkbox checked (under `Overall`). Add your userid `anasharm`. Make sure it also has "Administer" privileges.
- Log out. Log in as `anasharm`. Once it all looks good, revert the Authorization settings for `Anonymous Users` and `Authenticated Users` to `Read` under `Overall`
- Configure `Manage Jenkins > Global Tool Configuration`
    + `JDK Installations > Add JDK` Name: `JDK1.8.0`, JAVA_HOME: `/usr/local/java`
    + `Git Installations > Add Git` Name: `git`, Path to Git installation: `/usr/local/bin/git`
    + `Gradle Installations > Add Gradle` Name: `gradle`, GRADLE_HOME: `/usr/local/gradle`
    + `Maven Installations > Add Maven` Name: `Maven-3.3.1`, GRADLE_HOME: `/usr/local/maven`
- Configure `Manage Jenkins > Configure Credentials`
    + Click on `Credentials` and then `System` in the left-hand-side menu. That should get you to a page titled "System"
    + The "System" page has a table with one entry: "Global Credentials (unrestricted)"
    + Click on dropdown arrow next to "Global Credentials (unrestricted)"
    + Click on "Add Credentials"
    + Create 3 entries: 
      - bitbucket (automation/****) to access Git repos (Username/Password)
      - global-docker (jenkins-ci.gen/****) to access Docker Repo (Username/Password)
      - ubuntu (jenkins master private ssh key) to access minions. Take output of `cat ~/.ssh/id_rsa` and put it in the "Private Key" text field (SSH Username with Private Key)
- Before you can add a Node in Jenkins master, the following steps are necessary
    + This assumes you already have `jenkins1-minion` virtual machine
    + Setup with all the necessary tools (`git`, `java`, `gradle`, `maven`, `go` and `docker`)
    + Install latest version of `git`:
      ```bash
      sudo apt-get install build-essential autoconf zlib1g-dev tcl tcl-dev gettext libcurl4-openssl-dev
      curl -L -O https://github.com/git/git/archive/v2.18.0.tar.gz
      tar -xvzf v2.18.0.tar.gz
      cd git-2.18.0
      make configure
      ./configure --prefix=/usr/local
      make all
      sudo make install

      # Check version
      exit
      git --version
      ``` 
    + SSH into the Jenkins Master VM (`jenkins1-code.cisco.com`). SSH into `jenkins1-minion.cisco.com`. Hit "yes" for the Host verification. 
    + `sudo mkdir -p /var/lib/jenkins/.ssh`
    + Copy the contents of `~/.ssh/known_hosts` into `/var/lib/jenkins/.ssh/known_hosts`
    + `sudo chown -R jenkins.jenkins /var/lib/jenkins/.ssh`
- Configure `Manage Jenkins > Manage Nodes` (to add a Slave Node). 
    + Create New Node
    + Enter Node Name
    + Select "Permanant Agent"
      - Name: minion-1
      - Description: minion-1
      - Number of executors: 2
      - Remote Root directory: /home/ubuntu/jenkins
      - Labels: minion-1
      - Usage: Use this node as much as possible
      - Launch Method: Launch agent agents via SSH
      - Host: jenkins1-minion.cisco.com
      - Credentials: ubuntu (jenkins master private ssh key)
      - You can configure Environment Variables and Tool Locations (OPTIONAL)
      - Click "Save"
- Configure `Manage Jenkins > Configure System`
    + Configure `SonarQube servers`:
      - Check the "Enable injection of SonarQube server configuration as build environment variables"
      - Name: **Sonar**
      - Server URL: **https://csqi4.cisco.com**
      - Server Authentication Token: *<get one from SQ>*
    + Configure `BitBucket Endpoints`. Add `BitBucket Server`.
      - Name: **gitscm**
      - Server URL: **https://gitscm.cisco.com**
      - Call can Merge: Checked
      - Check "Manage Hooks"
      - Credentials: **automation/**** (BitBucket Automation)**
      - Name: **gitscm-sb**
      - Server URL: **https://gitscm-sb.cisco.com**
      - Call can Merge: Checked
      - Check "Manage Hooks"
      - Credentials: **automation/**** (BitBucket Automation)**
      - Name: **gitscm-stage**
      - Server URL: **https://gitscm-stage.cisco.com**
      - Call can Merge: Checked
      - Check "Manage Hooks"
      - Credentials: **automation/**** (BitBucket Automation)**
    + Configure `Jenkins Location > System Admin Email Address`: **anasharm@cisco.com**
    + Configure `Global Pipeline Libraries`
      - Name: **cda-pipeline-tools**
      - Default version: **master**
      - Load Implicitly: **Checked**
      - Allow default version to be overridden: **Checked**
      - Include @Library changes in job recent changes: **Unchecked**
      - Retrieval Method: **Modern SCM**
      - Source Code Management: **Git**
      - Project Repository: **https://gitscm.cisco.com/scm/cda/cda-jenkins-multipipeline-lib.git**
      - Credentials: **automation/**** (BitBucket Automation)**
    + Configure `Artifactory Servers`. Add `Artifactory Server`
      - Server ID: `-997609203@1397121225175`
      - URL: `https://repo-art.cisco.com/artifactory`
      - Default Deployer Credentials: `jenkins-ci.gen`
      - Password: `...`
    + Configure `CDA Build Activity` 
      - CDA URL: **https://cdanalytics.cisco.com**
      - Enable Event Proxy API 2.0: **Checked**
      - Event Proxy API 2.0 URL: **https://dftapi.cisco.com/code/cda/event-proxy/v2/software/event**
      - Enable CI Activity Event: **Checked**
      - Enable SCM Activity Event: **Checked**
      - Enable Software Profile Activity Event: **Checked**
      - Enable Platform Activity Event: **Checked**
      - Metadata API URL: **https://dftapi.cisco.com/code/cda/metadata/v2/software**
    + Configure `Extended Email Notification`
      - SMTP Server: **outbound.cisco.com**
      - Default user E-mail Prefix: **@cisco.com**
    + Email Notification
      - SMTP Server: **outbound.cisco.com**
      - Default user E-mail Prefix: **@cisco.com**
- Configure `Manage Jenkins > Jenkins CLI`:

    + To interact with Jenkins CLI, download the jar file:

```bash
curl -L -O https://ci6.cisco.com/jnlpJars/jenkins-cli.jar
```

    + Use help command. For example:

```bash
java -jar jenkins-cli.jar -s https://ci6.cisco.com -auth anasharm:fd42059e120bf3de8d1d61894580a774 help console
```



