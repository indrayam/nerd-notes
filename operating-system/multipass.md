# multipass

## Installation on Mac

```bash
brew cask install multipass
sudo multipass set local.driver=virtualbox
multipass set client.primary-name=bionic
```

## Basic Interactions

```bash
m launch
m ls
m stop <instance-name>
m delete <instance-name>
m purge <instance-name>
m info <instance-name>
```