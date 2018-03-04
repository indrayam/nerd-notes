# openssl

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
openssl enc -aes-256-cbc -e -in linux-bootstrap.tar.gz -out linux-bootstrap.tar.gz.enc
```

#### Decrypt an encrypted file

```bash
openssl aes-256-cbc -d -in linux-bootstrap.tar.gz.enc -out linux-bootstrap.tar.gz
```

![Stackoverflow Snippet 2](https://s3.amazonaws.com/us-east-1-anand-files/media-files-shared/openssl-footer.png)
