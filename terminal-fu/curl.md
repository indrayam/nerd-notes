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
curl --cacert cacert.pem https://daniel.haxx.se
}
```




