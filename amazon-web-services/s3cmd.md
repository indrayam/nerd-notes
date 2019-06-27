# s3cmd

### Basic Configuration
s3cmd --configure s3://us-east-1-anand-files

### Listing files
s3cmd ls s3://us-east-1-anand-files/media-files/

### Get a single file
s3cmd get s3://us-east-1-anand-files/media-files/localization-logo-512x512.png

### Get all files inside a bucket recursively
s3cmd get --recursive s3://us-east-1-anand-files/media-files/

### Configure s3cmd to interact with Cisco Cloud Storage

- Find the case notes when your object storage was provisioned. It should have information that looks like:

```bash
Endpoint: alln-cloud-storage-1.cisco.com
"user": "cd_code$cd",
"access_key": "...",
"secret_key": "..."
```
- Focus on the value of "user". Everything before the "$" sign is the tenant name. So, in our example, `cd_code` is the tenant name
- The HTTPS URL to access files stored inside Cloud Storage would be derived using this logic: `https://<end-point>/<tenant-name>:<bucket-name>/<file-name>`. Assuming you create a bucket named "demo" and inside the bucket you have a file named "hello.txt", the URL to access this file would be `https://alln-cloud-storage-1.cisco.com/cd_code:demo/hello.txt`
- Copy `.s3cfg` to `.s3cfg.bk` and then edit `.s3cfg` as follows:

```bash
[default]
# Setup endpoint
host_base = alln-cloud-storage-1.cisco.com
host_bucket = alln-cloud-storage-1.cisco.com
bucket_location = us-east-1
use_https = True

# Setup access keys
access_key =  ...
secret_key = ...

# Enable S3 v4 signature APIs
signature_v2 = False
```

Following s3cmd commands can be used to interact with Cisco Cloud Storage:

```bash
s3cmd ls
# Create a bucket
s3cmd mb s3://demo
# Put a file inside the bucket. This file will NOT be publicly accessible
s3cmd put cd-console.png s3://demo
# List all files inside your account
s3cmd la
# Get the file from the Cloud Storage
s3cmd get s3://demo/cd-console.png demo.png
# Make a file public
s3cmd --acl-public setacl s3://demo/cd-console.png
# Fetch the file
curl -L -O "https://alln-cloud-storage-1.cisco.com/cd_code:demo/cd-console.png"
```

