# curl

## Usage 1

```bash
curl -O <http...>
```

## Usage 2

```bash
curl -L -O <http...>
```

## Usage 3

```bash
curl -o <local-path> <http...>
```

## Usage 4
TODO: Need to understand this better...

```bash
curl https://sdk.cloud.google.com | sudo bash
```

## Usage 5

```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
```

## Usage 6

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

## Usage 7

```bash
curl -s http://releases.ubuntu.com/17.10/SHA256SUMS
```

## Get the CA Cert from curl

[Get the CA Cert for curl](https://daniel.haxx.se/blog/2018/11/07/get-the-ca-cert-for-curl/)

When you use curl to communicate with a HTTPS site (or any other protocol that uses TLS), it will by default verify that the server is signed by a trusted Certificate Authority (CA). It does this by checking the CA bundle it was built to use, or instructed to use by the `--cacert` command line option.

Sometimes you end up with a sitation where you don't have the necessary CA cert in your bundle.

### Do not disable:

A first gut reaction is to disable the certificate check. Don't do that. 

### 2 ways to solving this issue:

1. Get an updated CA bundle from us

curl can be told to use a separate standalone file as CA store, and conveniently enough curl provides an [updated one on the curl web site](https://curl.haxx.se/docs/caextract.html). 

2.  Get it with `openssl` 

```bash
echo quit | openssl s_client -showcerts -servername server -connect server:443 > cacert.pem
```

For example:

```bash
{
echo quit | openssl s_client -showcerts -servername daniel.haxx.se -connect daniel.haxx.se:443 > cacert.pem
echo quit | openssl s_client -showcerts -servername kuard1-code.cisco.com -connect kuard1-code.cisco.com:443 > kuard1-code.pem

echo quit | openssl s_client -showcerts -servername jenkins-code.cisco.com -connect jenkins-code.cisco.com:443 > jenkins-code.pem
openssl x509 -in jenkins-code.pem -text
echo quit | openssl s_client -showcerts -servername spinnaker-code.cisco.com -connect spinnaker-code.cisco.com:443 > spinnaker-code.pem
openssl x509 -in spinnaker-code.pem -text
echo quit | openssl s_client -showcerts -servername spinnakerapi-code.cisco.com -connect spinnakerapi-code.cisco.com:443 > spinnakerapi-code.pem
openssl x509 -in spinnakerapi-code.pem -text

echo quit | openssl s_client -showcerts -servername jenkins1-code.cisco.com -connect jenkins1-code.cisco.com:443 > jenkins1-code.pem
openssl x509 -in jenkins1-code.pem -text
echo quit | openssl s_client -showcerts -servername spinnaker1-code.cisco.com -connect spinnaker1-code.cisco.com:443 > spinnaker1-code.pem
openssl x509 -in spinnaker1-code.pem -text
echo quit | openssl s_client -showcerts -servername spinnaker1api-code.cisco.com -connect spinnaker1api-code.cisco.com:443 > spinnaker1api-code.pem
openssl x509 -in spinnaker1api-code.pem -text


curl --cacert cacert.pem https://daniel.haxx.se
}
```




