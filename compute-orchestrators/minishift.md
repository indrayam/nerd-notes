# minishift

## Assumptions
Make sure you have Virtualbox installed

## Help
`minishift help`

## Install
[Download](https://github.com/minishift/minishift/releases/download/v1.23.0/minishift-1.23.0-darwin-amd64.tgz)

`minishift start --vm-driver=virtualbox`

You should get something like this...

```
...
...
Extracting
Image pull complete
OpenShift server started.

The server is accessible via web console at:
    https://192.168.99.100:8443

You are logged in as:
    User:     developer
    Password: <any value>

To login as administrator:
    oc login -u system:admin

-- Exporting of OpenShift images is occuring in background process with pid 11338.
```

### Version
`minishift version`

### Stop
`minishift stop`

### Status
`minishift status`

### Update
`minishift update`

### Logging in as Admin 

```bash
eval $(minishift oc-env)
oc login $(minishift ip):8443 -u admin -p admin
```


