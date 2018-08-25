### How I installed Spinnaker on OpenStack and DigitalOcean


#### Spinnaker Install Notes

```bash
[Run on VM running Nginx L4 TCP Proxy]

# Get Nginx updated
sudo vim /etc/nginx/tcppassthrough.conf (Update the Upstream Port numbers for 80 and 443)
sudo vim /etc/apt/sources.list.d/nginx.list 
#Add the following lines to nginx.list:
#    deb https://nginx.org/packages/mainline/ubuntu/ <CODENAME> nginx
#    deb-src https://nginx.org/packages/mainline/ubuntu/ <CODENAME> nginx
sudo apt-get remove nginx #Remove existing Nginx install (if any)
sudo apt-get install nginx

## Update /etc/nginx/nginx.conf with these changes to the http block...


    #include /etc/nginx/conf.d/*.conf;
    #include /etc/nginx/sites-enabled/*;
}

include /etc/nginx/tcppassthrough.conf;

## tcp LB  and SSL passthrough for backend ##
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


sudo nginx -t
sudo systemctl stop nginx
sudo systemctl start nginx

---
[Run on VM that will be the NFS Server]
sudo apt-get install -y nfs-kernel-server
sudo mkdir /var/nfs/minio -p
sudo chown nobody:nogroup /var/nfs/minio

sudo vim /etc/exports

/var/nfs/minio  64.102.178.0/23(rw,sync,no_subtree_check) 64.102.186.0/23(rw,sync,no_subtree_check)
sudo systemctl restart nfs-kernel-server

---
[Run on all k8s nodes]
sudo apt-get install nfs-common
{
    sudo mkdir -p /nfs/minio
    sudo mount 64.102.179.211:/var/nfs/minio /nfs/minio
    df -h
}

sudo vim /etc/fstab
64.102.179.211:/var/nfs/minio /nfs/minio nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
sudo umount /nfs/minio (if you need to)

---
[Run on VM that will run halyard]
### Install kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF | tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
### Fix K8s prompts
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

### Make sure .kube/config contains information about the Kubernetes cluster you would be installing stuff into

---
[Run on Halyard VM]
cd ~/src
tar -xvzf hal.tar.gz (get it from Dropbox)
sudo bash InstallHalyard.sh
dpkg -l | grep -i openjdk
sudo ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/local/java (assuming you are using openjdk)

### Create Spinnaker Kubernetes v2 Cloud Provider
# Setup Kubernetes Cluster
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

### Add Kubernetes Account
hal config provider kubernetes enable
hal config provider kubernetes account add spinnaker-code \
    --provider-version v2 \
    --context $(kubectl config current-context)
hal config features edit --artifacts true

### Choose Environment
hal config deploy edit --type distributed --account-name spinnaker-code

### Persistent Storage
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

### Deploy Spinnaker
VERSION="1.9.0"
hal config version edit --version $VERSION
hal deploy apply
cd ~/.hal/default/profiles
vim front50-local.yml (add: spinnaker.s3.versioning: false)
hal deploy apply

### Install Ingress Controller, cert-manager
k apply -f contour-deployment-rbac.yml
k -n heptio-contour get svc


### Cert Manager (Self-signed)
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -subj "/CN=Cisco CoDE Team" -days 3650 -reqexts v3_req -extensions v3_ca -out ca.crt
k create secret tls ca-key-pair --cert=ca.crt --key=ca.key --namespace=cert-manager
k apply -f ./ca-clusterissuer.yml
# Switch Namespace to Spinnaker
k apply -f ./spinnaker-code-ingress-https.yml -n spinnaker
k apply -f ./spinnakerapi-code-ingress-https.yml -n spinnaker

### Cert Manager (LetsEncrypt)
k apply -f ./letsencrypt-staging.yml
k apply -f ./letsencrypt-prod.yml

### Update Ingress
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

### Enable Security

hal config security authn ldap edit --user-dn-pattern="cn={0},OU=Employees,OU=Cisco Users" --url=ldap://ds.cisco.com:3268/DC=cisco,DC=com
# Note, I had to remove the space betweeen Cisco and Users when running this command and later edit the ~/.hal/config file 
# by adding the space
hal deploy apply
```

### Halyard CLI

```bash
hal config provider kubernetes account add cae-np-rtp-hcn --provider-version v2 --context cae-np-rtp_hcn
hal config provider kubernetes account add cae-np-alln-hcn --provider-version v2 --context cae-np-alln_hcn
hal config provider kubernetes account add cae-prd-rcdn-hcn --provider-version v2 --context cae-prd-rcdn_hcn

hal config provider docker-registry account add ech-hcn --address containers.cisco.com \
    --repositories "codeplayground/hello-udeploy-cloud-native-web-app" \
    --username "anasharm"  \
    --password "KWQOXLFdXR1gtZk72GH2RRqqVp+O+CHm/VxmU7YK3pA8ECntB8pfKe6yFk2cdKyR"
```
