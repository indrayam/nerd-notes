# cfssl, cfssljson

**ASN:** Abstract Syntax Notation.One (ASN.1) is an interface description language for defining data structures that can be serialized and deserialized in a standard, cross-platform way. It's broadly used in telecommunications and computer networking, and especially in cryptography. ASN.1 is similar in purpose and use to Protocol Buffers and Apache Thrift, which are also interface description languages for cross-platform data serialization. Like those languages, it has a schema (in ASN.1, called a "module"), and a set of encodings, typically type-length-value encodings. However, ASN.1, defined in 1984, predates them by many years. It also includes a wider variety of basic data types, some of which are obsolete, and has more options for extensibility.

**X509:** In cryptography, X.509 is a standard that defines the format of public key certificates. X.509 certificates are used in many Internet protocols, including TLS/SSL, which is the basis for HTTPS, the secure protocol for browsing the web. X.509 was initially issued on July 3, 1988 and was begun in association with the X.500 standard. It assumes a strict hierarchical system of certificate authorities (CAs) for issuing the certificates. This contrasts with web of trust models, like PGP, where anyone (not just special CAs) may sign and thus attest to the validity of others' key certificates.

**PEM:** Defined in RFC's 1421 through 1424, this is a container format that may include just the public certificate (such as with Apache installs, and CA certificate files /etc/ssl/certs), or may include an entire certificate chain including public key, private key, and root certificates. The name is from Privacy Enhanced Mail (PEM), a failed method for secure email but the container format it used lives on, and is a base64 translation of the x509 ASN.1 keys.

**DER:** The parent format of PEM. It's useful to think of it as a binary version of the base64-encoded PEM file. Not routinely used by much outside of Windows.

### Generate Root Certificate and Private Key

Two files are pre-requisites:
- ca-config.json
- ca-csr.json

You can create the defaults like this:

```bash
cfssl print-defaults list # Gives you the list of types that cfssl will generate defaults for
cfssl print-defaults config > ca-config.json
cfssl print-defaults csr > ca-config.json
```

```bash
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
```

This will generate the following three files:
- ca.pem
- ca-key.pem
- ca.csr

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

### Generate Server Certificate and Private Key

```bash
cfssl print-defaults csr > server-csr.json # *DO NOT FORGET* to edit the values in server-csr.json for your needs
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server server-csr.json | cfssljson -bare server
```

### Generate Client Certificate and Private Key

```bash
cfssl print-defaults csr > client-csr.json # *DO NOT FORGET* to edit the values in server-csr.json for your needs
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server client-csr.json | cfssljson -bare client
```

### Generate Peer Certificate and Private Key

```bash
cfssl print-defaults csr > member1-csr.json # *DO NOT FORGET* to edit the values in server-csr.json for your needs
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=peer member1-csr.json | cfssljson -bare member1
```
