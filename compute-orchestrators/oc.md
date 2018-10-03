# oc

### install oc (linux)

```bash
curl -L -O https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
tar -xvzf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
```

### install oc (mac)

```bash
brew install openshift-cli
```

### install oc in an alpine docker container

The oc binary is linked against GNU libc so it will not work, just like binaries compiled for windows or OSX will not work. That said, musl libc provides partial GNU libc compatibility, which means that some binaries will actually work, even if there are no guarantee. Try `apk add libc6-compat`. Turns out `oc` worked!

```bash
apk add libc6-compat
curl -L -O https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
tar -xvzf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
```

### help

```bash
oc help
```

### version

```bash
oc version
```

### login

```bash
oc login https://api.starter-us-east-1.openshift.com --token=...
```
