# openssl

### Reference
Refer to cfssl document for more examples on certificate creation

### Create SSL Cert for Web Server
- [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)
- [Reference Gist on GitHub](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)
- [OpenSSL Essentials: Working with SSL Certificates, Private Keys and CSRs](https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs)

**Create Root CA (Done Once)**

```bash
openssl genrsa -out ca.key 4096
```
If you want a password protected key, use the following

```bash
openssl genrsa -des3 -out ca.key 4096
```

**Create and self-sign the Root Certificate**

```bash
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt

# Another flavor
openssl req -key ./helm-tiller-ca.key.pem -new -x509 -days 1095 -sha256 -out helm-tiller-ca.cert.pem -extensions v3_ca
```

**Create a certificate (Done for each server)**

1. Create the certificate key

```bash
openssl genrsa -out jenkins1-code.cisco.com.key 2048
```

2. Create the signing request (Certificate Signing Request - CSR)

Interactive

```bash
openssl req -new \
    -key jenkins1-code.cisco.com.key \
    -out jenkins1-code.cisco.com.csr
```

OR

Non-Interactive

```bash
openssl req -new -sha256 \
    -key jenkins-code.cisco.com.key \
    -subj "/C=US/ST=NC/O=CoDE, Inc./CN=jenkins-code.cisco.com" \
    -out jenkins-code.cisco.com.csr
```

If you need to pass additional config you can use the -config parameter, here for example I want to add alternative names to my certificate.

```bash
openssl req -new -sha256 \
    -key jenkins-code.cisco.com.key \
    -subj "/C=US/ST=NC/O=CoDE, Inc./CN=jenkins-code.cisco.com" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:jenkins-code.cisco.com")) \
    -out jenkins-code.cisco.com.csr
```

3. Verify the CSR's content

```bash
openssl req -in jenkins-code.cisco.com.csr -noout -text
```

4. Generate Certificate using the CSR and Key along with the CA Root key

```bash
openssl x509 -req -sha256 \
    -in jenkins-code.cisco.com.csr \
    -CA ca.crt \
    -CAkey ca.key \
    -CAcreateserial \
    -out jenkins-code.cisco.com.crt \
    -extensions SAN \
    -extfile <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:jenkins-code.cisco.com")) \
    -days 500
```

5. Verify the Certificate

```bash
openssl x509 -in jenkins-code.cisco.com.crt -text -noout
```

### Generate Certificate and Key

```bash
{
USER=philip
openssl genrsa -out ${USER}.key 2048 # Get Key
openssl req -new -key ${USER}.key -out ${USER}.csr -subj "/CN=${USER}/O=CoDE" # Create a CSR
openssl x509 -req -in ${USER}.csr -CA ./kubernetes.crt -CAkey ./kubernetes.key -CAcreateserial -out ${USER}.crt # Generate Certificate
}
```

### Interact with Certificates

```bash
cfssl certinfo -cert ca.pem # print the certificate in JSON format

openssl x509 -text -in ca.pem # print the certificate in text form (-text)
openssl x509 -text -noout -in ca.pem # print the certificate in text form (-text), minus the certificate (-noout)
openssl x509 -noout -subject -in ca.pem # print the Subject field from the certificate
openssl x509 -noout -issuer -in ca.pem # print the Issuer field from the certificate
openssl x509 -noout -email -in ca.pem # print the Email field from the certificate
openssl x509 -noout -dates -in ca.pem # print the Start and End dates field from the certificate
openssl x509 -noout -startdate -in ca.pem # print the Start Date field from the certificate
openssl x509 -noout -enddate -in ca.pem # print the End Date field from the certificate
openssl x509 -noout -pubkey -in ca.pem # print the Public Key
```

### Interact with Certificate Signing Request

```bash
cfssl certinfo -csr ca.pem # print the certificate signing request in JSON format

openssl req -in ca.csr #print the certificate request
openssl req -text -in ca.csr #print the certificate request in text form
openssl req -text -noout -in ca.csr #print the certificate request in text form without the certificate
```

### Interact with Private key

```bash
openssl rsa -in ca-key.pem #print the (RSA) private key
openssl rsa -text -in ca-key.pem #print the private key in text format
openssl rsa -text -noout -in ca-key.pem #print the private key in text format, but do not print the private key out
openssl rsa -outform DES -in ca-key.pem #print the private key in DES 
```

```bash
openssl req -in ca.csr #print the certificate request
openssl req -text -in ca.csr #print the certificate request in text form
openssl req -text -noout -in ca.csr #print the certificate request in text form without the certificate
```

#### Create Base64 encoding (The values of the encoded output should be exactly the same if the input string is the same. Be careful about spaces and newlines at the end of the string)

```bash
echo -n "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJKb2UifQ" | openssl base64 -e -A
echo -n "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJKb2UifQ" | base64
```

#### Create Base64 decoding (The values of the encoded output should be exactly the same if the input string is the same. Be careful about spaces and newlines at the end of the string)

```bash
openssl enc -base64 -d <<< ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKemRXSWlPaUpLYjJVaWZR 
OR
echo -n “ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKemRXSWlPaUpLYjJVaWZR” | openssl base64 -d -A
echo -n "ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKemRXSWlPaUpLYjJVaWZR" | base64 --decode
```

#### Poor man’s Base64URL Encoding

```bash
echo -n "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJKb2UifQ" | openssl base64 -e -A | sed s/\+/-/ | sed -E s/=+$//
echo -n "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJKb2UifQ" | base64 | sed s/\+/-/ | sed -E s/=+$//
```

![Stackoverflow Snippet 1](https://s3.amazonaws.com/us-east-1-anand-files/media-files-shared/base64-encoding.png)

#### Create SHA256 digest in a hexadecimal format

```bash
echo -n "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0=" | openssl dgst -sha256
perl -e "print qq(eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0=)" | openssl dgst -sha256
ea8508d2d4b6bc3ab82b5396aeb23f715e23f6c82761f49de935a8a0e6ec094f
```

#### Create SHA256 digest with secret “secret” in a hexadecimal format

```bash
echo -n "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0=" | openssl dgst -sha256 -hmac ‘secret’
perl -e "print qq(eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0=)" | openssl dgst -sha256 -hmac 'secret'
990d53e547ddd1335bd1a8f60094a8ea2d0324a4b3be921261b4cabd1781c27e
```

#### Create SHA256 digest with secret “secret” in a binary format

```bash
echo -n "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0=" | openssl dgst -sha256 -hmac ‘secret’ -binary
perl -e "print qq(eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY290Y2guaW8iLCJleHAiOjEzMDA4MTkzODAsIm5hbWUiOiJDaHJpcyBTZXZpbGxlamEiLCJhZG1pbiI6dHJ1ZX0=)" | openssl dgst -sha256 -hmac ‘secret’ -binary
990d53e547ddd1335bd1a8f60094a8ea2d0324a4b3be921261b4cabd1781c27e
```

#### Create Base64 encoding of binary data

```bash
openssl base64 -in <filename>
```

#### Create Hex from a binary file

```bash
xxd -p -c 256 digest.bin
```

Why do we need the digest to be dumped in binary format? Because if you do not, `openssl dgst -sha256…` command will spit out hex-encoded digest. If you feed that to base64, it will also treat is as a string as opposed to what it really is: Hex-encoded binary data!. More explanation [here](http://stackoverflow.com/questions/32188149/difference-between-cryptojs-enc-base64-stringify-and-normal-base64-encryption)

Use this online converter until you figure out how to do it on the command line...
[Text Converter](http://www.percederberg.net/tools/text_converter.html)

#### Encrypt a file 

```bash
openssl aes-256-cbc -e -in bash-bootstrap-kubernetes.tar.gz -out bash-bootstrap-kubernetes-0.tar.gz.enc
# If using OpenSSL 1.1.1, use the following...
openssl aes-256-cbc -pbkdf2 -e -in bash-bootstrap-kubernetes.tar.gz -out bash-bootstrap-kubernetes-1.tar.gz.enc
```

#### Decrypt an encrypted file

```bash
openssl aes-256-cbc -d -in linux-bootstrap.tar.gz.enc -out linux-bootstrap.tar.gz
# If using OpenSSL 1.1.1, use the following...
openssl aes-256-cbc -pbkdf2 -d -in bash-bootstrap.tar.gz.enc -out bash-bootstrap.tar.gz
```

![Stackoverflow Snippet 2](https://s3.amazonaws.com/us-east-1-anand-files/media-files-shared/openssl-footer.png)
