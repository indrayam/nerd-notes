# doctl help
doctl is a command line interface for the DigitalOcean API.

Usage:
  doctl [command]

Available Commands:
  account     account commands
  auth        auth commands
  completion  completion commands
  compute     compute commands
  version     show the current version

Flags:
  -t, --access-token string   API V2 Access Token
  -u, --api-url string        Override default API V2 endpoint
  -c, --config string         config file (default is $HOME/.config/doctl/config.yaml)
  -o, --output string         output format [text|json] (default "text")
      --trace                 trace api access
  -v, --verbose               verbose output

Use "doctl [command] --help" for more information about a command.

## Getting help for a sub-command (for example: Here's how you get help for "account" sub-command)
doctl account help

## Login
doctl auth init

## Show my current configuration
doctl account get

## Get version
doctl version

# doctl auth sub-command
(auth is used to access auth commands)

# doctl compute sub-command
(compute commands are for controlling and managing infrastructure)

## Get help for doctl compute sub-command
doctl compute --help

# doctl compute ssh-key sub-command
(sshkey is used to access ssh key commands)

## Get the public key stored with DO
doctl compute ssh-key list

# doctl compute region sub-command
(region is used to access region commands)

## Get a list of all the regions where DO has a presence
doctl compute region list

# doctl compute droplet sub-command
(droplet is used to access droplet commands)

## List Droplets
doctl compute droplet list

## Create a Droplet using an existing snapshot
doctl compute droplet create snowy-machine --size 1gb --image 28487138 --region nyc1 --ssh-keys 52:a4:4d:f6:49:e4:6a:49:89:b5:b0:e3:69:7a:d2:08

# doctl compute droplet-action sub-command
(droplet-action is used to access droplet action commands)

## Create Snapshot
doctl compute droplet-action snapshot 65972442  --snapshot-name ubuntu-16-04-x64-ez

## Check the status of the snapshot creation droplet action
doctl compute droplet-action get 65972442 --action-id 331141167

# doctl compute snapshot sub-command
(snapshot is used to access snapshot commands)

## List Snapshots
doctl compute snapshot list

## Delete Snapshot
doctl compute snapshot delete 29545046 

# doctl compute image-action sub-command
(image-action is used to access image-action commands)

## Add a Snapshot to another region
doctl compute image-action transfer 29727973 --region nyc2
doctl compute image-action transfer 29727973 --region nyc3

## Check the status of the snapshot transfer
doctl compute image-action get 65972442 --action-id <action-id>

# doctl compute image sub-command
(image commands)

## List images
doctl compute image list

# doctl compute domain sub-command
(domain is used to access domain commands)

## Get list of all domain records for a particular domain
doctl compute domain records list indrayam.com

## Update domain record for a particular domain
doctl compute domain records update indrayam.com --record-id 29030573 --record-type A --record-data 138.197.10.134 --record-ttl 3600
doctl compute domain records update indrayam.com --record-id 29030578 --record-type A --record-data 138.197.102.0 --record-ttl 3600
doctl compute domain records update indrayam.com --record-id 29030583 --record-type A --record-data 138.197.102.8 --record-ttl 3600
doctl compute domain records update indrayam.com --record-id 29030528 --record-type A --record-data 67.205.140.125 --record-ttl 3600
doctl compute domain records update indrayam.com --record-id 29030591 --record-type A --record-data 67.205.140.125 --record-ttl 3600

## Create domain record for a particular domain
doctl compute domain records create indrayam.com --record-name e --record-type A --record-data 192.241.159.40 --record-ttl 3600
doctl compute domain records create indrayam.com --record-name f --record-type A --record-data 35.194.71.129 --record-ttl 3600
doctl compute domain records create indrayam.com --record-name g --record-type A --record-data 35.199.45.255 --record-ttl 3600
