# Minio Client (mc)

Minio comes with a very nice Web UI to access the data. Just point your browser to:

`http://localhost:9000`

You can also use `s3cmd` to browse minio content from the command line. Just copy the file `$HOME/.s3cfg` into `$HOME\.miniocfg` and replace all the text with something like:

```bash
[default]
# Setup endpoint
host_base = localhost:9000
host_bucket = localhost:9000
#bucket_location = us-east-1
use_https = False

# Setup access keys
access_key =  <access-key>
secret_key = <access-secret>

# Enable S3 v4 signature APIs
signature_v2 = True
```

### Install

```bash
brew install mc
```

### Configuration file

```bash
cat $HOME/.mc/config.json
# The aliases for the different hosts is what will be used
```

### List all files recursively in a Minio Server

```bash
# mc ls -r <minio host alias>
mc ls -r local
```

### List all files in a bucket

```bash
# mc ls -r <minio host alias>
mc ls -r local/<bucket-name-or-path>
```
