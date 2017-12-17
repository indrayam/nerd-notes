# md5sum

### Match Hash
TODO: Not sure what is happening here...

```bash
echo "$(curl -s https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest.md5) /usr/local/bin/ecs-cli" | md5sum -c -
```
