# minishift

## Assumptions
Make sure you have Virtualbox installed

## Help
`minishift help`

## Install
[Source](https://docs.openshift.org/latest/minishift/getting-started/installing.html)

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

## Version
`minishift version`

## Stop
`minishift stop`

## Status
`minishift status`

## Update
`minishift update`


