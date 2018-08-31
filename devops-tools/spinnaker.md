# Spinnaker Install Notes on Kubernetes

## [Run on VM running Nginx L4 TCP Proxy] 

### Get Nginx updated
```bash
sudo vim /etc/nginx/tcppassthrough.conf (Update the Upstream Port numbers for 80 and 443)
sudo vim /etc/apt/sources.list.d/nginx.list 
#Add the following lines to nginx.list:
#    deb https://nginx.org/packages/mainline/ubuntu/ <CODENAME> nginx
#    deb-src https://nginx.org/packages/mainline/ubuntu/ <CODENAME> nginx
```

```bash
sudo apt-get remove nginx #Remove existing Nginx install (if any)
sudo apt-get install nginx
```

### Update /etc/nginx/nginx.conf with these changes to the http block...

```bash
    #include /etc/nginx/conf.d/*.conf;
    #include /etc/nginx/sites-enabled/*;
}

include /etc/nginx/tcppassthrough.conf;
```

### TCP LB  and SSL passthrough for backend ##

```bash
stream {
    upstream httpenvoy {
        server 64.102.179.84:31913 max_fails=3 fail_timeout=10s;
        server 64.102.178.218:31913 max_fails=3 fail_timeout=10s;
        server 64.102.179.202:31913 max_fails=3 fail_timeout=10s;
        server 64.102.179.80:31913 max_fails=3 fail_timeout=10s;
        server 64.102.179.228:31913 max_fails=3 fail_timeout=10s;
    }

    upstream httpsenvoy {
        server 64.102.179.84:31913 max_fails=3 fail_timeout=10s;
        server 64.102.178.218:31913 max_fails=3 fail_timeout=10s;
        server 64.102.179.202:31913 max_fails=3 fail_timeout=10s;
        server 64.102.179.80:31913 max_fails=3 fail_timeout=10s;
        server 64.102.179.228:31913 max_fails=3 fail_timeout=10s;
    }

    server {
        listen 80;
        proxy_pass httpenvoy;
        proxy_next_upstream on;
    }

    server {
        listen 443;
        proxy_pass httpsenvoy;
        proxy_next_upstream on;
    }
}
```

```bash
sudo nginx -t
sudo systemctl stop nginx
sudo systemctl start nginx
```

## [Run on VM that will be the NFS Server]

### Setup NFS Server


```bash
sudo apt-get install -y nfs-kernel-server
sudo mkdir /var/nfs/minio -p
sudo chown nobody:nogroup /var/nfs/minio

sudo vim /etc/exports

/var/nfs/minio  64.102.178.0/23(rw,sync,no_subtree_check) 64.102.186.0/23(rw,sync,no_subtree_check)
sudo systemctl restart nfs-kernel-server
```

## [Run on all k8s nodes]

### Setup NFS Client

```bash
sudo apt-get install nfs-common
{
    sudo mkdir -p /nfs/minio
    sudo mount 64.102.179.211:/var/nfs/minio /nfs/minio
    df -h
}
```

```bash
sudo vim /etc/fstab
64.102.179.211:/var/nfs/minio /nfs/minio nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
sudo umount /nfs/minio (if you need to)
```

## [Run on VM that will run halyard]

### Install kubectl

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF | tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
```

### Install gcloud

```bash
{
    # Create environment variable for correct distribution
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

    # Add the Cloud SDK distribution URI as a package source
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    # Import the Google Cloud Platform public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    # Update the package list and install the Cloud SDK
    sudo apt-get update && sudo apt-get install google-cloud-sdk
}

```

### Fix K8s prompts

```bash
cd $HOME
git clone git@github.com:jonmosco/kube-ps1.git .kube-ps1
exit
{
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
rm -f /usr/local/bin/kubectx /usr/local/bin/kubens /usr/local/bin/stern
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
curl -L -O https://github.com/wercker/stern/releases/download/1.8.0/stern_linux_amd64
chmod +x stern_linux_amd64
sudo mv stern_linux_amd64 /usr/local/bin/stern
curl -L -O https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
tar -xvzf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
sudo mv openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit /opt/openshift/
sudo ln -s /opt/openshift/oc /usr/local/bin/oc
}
```

Make sure .kube/config contains information about the Kubernetes cluster you would be installing stuff into

## [Run on Halyard VM]

```bash
{
cd ~/src
tar -xvzf hal.tar.gz (get it from Dropbox)
sudo bash InstallHalyard.sh
dpkg -l | grep -i openjdk
sudo ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/local/java (assuming you are using openjdk)
}
```

### Create Spinnaker Kubernetes v2 Cloud Provider: Setup Kubernetes Cluster

```bash
cd ~/src
k create namespace spinnaker
k create -f sa.yml
CONTEXT=k8s-on-p3-rtp
TOKEN=$(kubectl get secret --context $CONTEXT \
   $(kubectl get serviceaccount spinnaker-service-account \
       --context $CONTEXT \
       -n spinnaker \
       -o jsonpath='{.secrets[0].name}') \
   -n spinnaker \
   -o jsonpath='{.data.token}' | base64 --decode)

kubectl config set-credentials ${CONTEXT}-token-user --token $TOKEN
```

### Add Kubernetes Account

```bash
hal config provider kubernetes enable
hal config provider kubernetes account add spinnaker-code \
    --provider-version v2 \
    --context $(kubectl config current-context)
hal config features edit --artifacts true
```

### Choose Environment

```bash
hal config deploy edit --type distributed --account-name spinnaker-code
```

### Persistent Storage

```bash
cd ~/src
vim ./minio-standalone-pv.yml (Set the IP address of the NFS server)
k apply -f ./minio-standalone-pv.yml
k apply -f ./minio-standalone-pvc.yml
k apply -f ./minio-standalone-deployment.yml
vim ./minio-standalone-service.yml (Set the Service Type to Cluster IP)
k apply -f ./minio-standalone-service.yml
{
MINIO_ACCESS_KEY="NQGLI04VLERHGQI8X7SW"
MINIO_SECRET_KEY="4hIXeYg5I0WS15tOdCG7PAHVq4YiaHGJp2w3QwCC"
ENDPOINT="http://minio-service:9000"
echo $MINIO_SECRET_KEY | hal config storage s3 edit --endpoint $ENDPOINT \
    --access-key-id $MINIO_ACCESS_KEY \
    --secret-access-key
}
hal config storage edit --type s3
```

### Deploy Spinnaker

```bash
VERSION="1.9.0"
hal config version edit --version $VERSION
hal deploy apply
cd ~/.hal/default/profiles
vim front50-local.yml (add: spinnaker.s3.versioning: false)
hal deploy apply
```

### Install Ingress Controller, cert-manager

```bash
k apply -f contour-deployment-rbac.yml
k -n heptio-contour get svc
```

### Cert Manager (Self-signed)

```bash
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -subj "/CN=Cisco CoDE Team" -days 3650 -reqexts v3_req -extensions v3_ca -out ca.crt
k create secret tls ca-key-pair --cert=ca.crt --key=ca.key --namespace=cert-manager
k apply -f ./ca-clusterissuer.yml
```

### Switch Namespace to Spinnaker

```bash
k apply -f ./spinnaker-code-ingress-https.yml -n spinnaker
k apply -f ./spinnakerapi-code-ingress-https.yml -n spinnaker
```

### Cert Manager (LetsEncrypt)

```bash
k apply -f ./letsencrypt-staging.yml
k apply -f ./letsencrypt-prod.yml
```

### Update Ingress

```bash
k apply -f ./spinnaker-code-ingress-https.yml
k apply -f ./spinnakerapi-code-ingress-https.yml

hal config security ui edit \
    --override-base-url http://spinnaker-code.cisco.com

hal config security ui edit \
    --override-base-url https://spinnaker-code.cisco.com

hal config security api edit \
    --override-base-url http://spinnakerapi-code.cisco.com

hal config security api edit \
    --override-base-url https://spinnakerapi-code.cisco.com
```

### Enable Security

```bash
hal config security authn ldap edit --user-dn-pattern="cn={0},OU=Employees,OU=Cisco Users" --url=ldap://ds.cisco.com:3268/DC=cisco,DC=com
# Note, I had to remove the space betweeen Cisco and Users when running this command and later edit the ~/.hal/config file 
# by adding the space
hal deploy apply
```

### Add Kubernetes Accounts

```bash
hal config provider kubernetes account add cae-np-rtp-hcn --provider-version v2 --context cae-np-rtp_hcn
hal config provider kubernetes account add cae-np-alln-hcn --provider-version v2 --context cae-np-alln_hcn
hal config provider kubernetes account add cae-prd-rcdn-hcn --provider-version v2 --context cae-prd-rcdn_hcn

hal config provider docker-registry account add ech-hcn --address containers.cisco.com \
    --repositories "codeplayground/hello-udeploy-cloud-native-web-app" \
    --username "anasharm"  \
    --password "KWQOXLFdXR1gtZk72GH2RRqqVp+O+CHm/VxmU7YK3pA8ECntB8pfKe6yFk2cdKyR"
```

### Authentication UI

```html
<html><head><title>Login Page</title></head><body onload='document.f.username.focus();'>
<h3>Login with Username and Password</h3><form name='f' action='/login' method='POST'>
<table>
    <tr><td>User:</td><td><input type='text' name='username' value=''></td></tr>
    <tr><td>Password:</td><td><input type='password' name='password'/></td></tr>
    <tr><td colspan='2'><input name="submit" type="submit" value="Login"/></td></tr>
</table>
</form></body></html>
```

### Add Jenkins Support

```bash
{
hal config ci jenkins enable

PASSWORD='Maltose$$.123'
echo $PASSWORD | hal config ci jenkins master add my-jenkins-master \
    --address https://ci6.cisco.com \
    --username jenkins-ci.gen \
    --password
}
```

### Change the timezone

```bash
hal config edit --timezone 'America/New_York'
```

Not sure if this worked though. Not at the UI level

### HTTP Artifact Support

```bash
{
USERNAME='automation'
PASSWORD='aut0mati0n'
USERNAME_PASSWORD_FILE='/home/ubuntu/.bitbucket-user'
echo ${USERNAME}:${PASSWORD} > $USERNAME_PASSWORD_FILE
GITSCM_HTTP_ARTIFACT_ACCOUNT_NAME=automation-gitscm
hal config features edit --artifacts true
hal config artifact http enable
hal config artifact http account add ${GITSCM_HTTP_ARTIFACT_ACCOUNT_NAME} \
    --username-password-file $USERNAME_PASSWORD_FILE
}
```

### GitHub Artifact Support

```bash
{
TOKEN='2193da351555ffde81fc563a5546f2ebf7b2e3e3'
TOKEN_FILE='/home/ubuntu/.github-token'
echo $TOKEN > $TOKEN_FILE
GITHUB_ARTIFACT_ACCOUNT_NAME=indrayam-github
hal config features edit --artifacts true
hal config artifact github enable
hal config artifact github account add $GITHUB_ARTIFACT_ACCOUNT_NAME \
    --token-file $TOKEN_FILE
}
```

### GCS Artifact Support

```bash
{
    SERVICE_ACCOUNT_NAME='spinnaker-gce-account'
    SERVICE_ACCOUNT_DEST='/home/ubuntu/.config/gcloud/evident-wind-163400-spinnaker.json'
    
    #gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME --display-name $SERVICE_ACCOUNT_NAME
    
    SA_EMAIL=$(gcloud iam service-accounts list \
        --filter="displayName:$SERVICE_ACCOUNT_NAME" \
        --format='value(email)')
    
    PROJECT=$(gcloud info --format='value(config.project)')

    gcloud projects add-iam-policy-binding $PROJECT \
        --role roles/storage.admin --member serviceAccount:$SA_EMAIL

    #mkdir -p $(dirname $SERVICE_ACCOUNT_DEST)

    #gcloud iam service-accounts keys create $SERVICE_ACCOUNT_DEST --iam-account $SA_EMAIL
    ARTIFACT_ACCOUNT_NAME=evident-wind-gcs
    hal config features edit --artifacts true
    hal config artifact gcs account add $ARTIFACT_ACCOUNT_NAME \
        --json-path $SERVICE_ACCOUNT_DEST
}
```

### Email Notification Support

1. Create echo-local.yml file as below:

```bash
mail:
  enabled: true
  from: noreply@cisco.com
spring:
  mail:
    host: outbound.cisco.com
    port: 25
    properties:
      mail:
        smtp:
          auth: false
          starttls:
            enable: true
        transport:
          protocol: smtp
        debug: true
```

2. Copy the file into ~/.hal/default/profiles/ folder
3. Run: `hal deploy apply --service-names echo`



