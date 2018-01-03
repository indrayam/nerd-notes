# shasum, md5sum, sha256sum

## md5sum

```bash
echo "$(curl -s https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest.md5) /usr/local/bin/ecs-cli" | md5sum -c -
```

## shasum

```bash
echo "$(curl -s http://releases.ubuntu.com/17.10/SHA1SUMS | grep -i ubuntu-17.10-server-amd64.iso)" | shasum -c -
```

## sha256sum

```bash
echo "$(curl -s http://releases.ubuntu.com/17.10/SHA256SUMS | grep -i ubuntu-17.10-server-amd64.iso)" | shasum -a 256 -c -
```

