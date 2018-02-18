# doctl user data

### Default user data in each droplet

```bash
#!/bin/bash
cd ~
curl -O https://s3.amazonaws.com/us-east-1-anand-files/misc-files/step.sh
chmod 755 ~/step.sh
```
