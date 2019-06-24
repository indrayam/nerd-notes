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

Copy `.s3cfg` to `.s3cfg.bk`

Edit `.s3cfg` as follows:

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

Run the following commands to interact with Cisco Cloud Storage:

```bash
s3cmd ls
s3cmd mb s3://demo
s3cmd put cd-console.png s3://demo
s3cmd la
```
