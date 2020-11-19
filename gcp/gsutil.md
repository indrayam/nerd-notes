# gsutil

### help
gsutil help cp

### Copy files to a bucket
gsutil cp test.txt gs://us-east-4-anand-files

### Copy files from a bucket
gsutil cp gs://us-east-4-anand-files/misc-files/config .

### Copy a folder/multiple files to a bucket
gsutil -m cp -r media-files gs://us-east-4-anand-files

### Make Container Registry Public
gsutil iam ch allUsers:objectViewer gs://us.artifacts.evident-wind-163400.appspot.com/


gs://us-east-4-anand-files/misc-files/config
