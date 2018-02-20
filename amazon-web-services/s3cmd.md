# s3cmd

### Basic Configuration
s3cmd --configure s3://us-east-1-anand-files

### Listing files
s3cmd ls s3://us-east-1-anand-files/media-files/

### Get a single file
s3cmd get s3://us-east-1-anand-files/media-files/localization-logo-512x512.png

### Get all files inside a bucket recursively
s3cmd get --recursive s3://us-east-1-anand-files/media-files/
