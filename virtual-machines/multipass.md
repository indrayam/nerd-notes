# multipass

## Installation on Mac

```bash
brew cask install multipass
sudo multipass get local.driver
sudo multipass set local.driver=virtualbox
sudo multipass set local.driver=hyperkit
sudo multipass get client.primary-name
sudo multipass set client.primary-name=noble
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

## Starting the daemon

```bash
launchctl service com.canonical.multipassd
```

## Uninstall Multipass

[Source](https://github.com/canonical/multipass/issues/2265)

```bash
sudo sh "/Library/Application Support/com.canonical.multipass/uninstall.sh"
```

## Logs

```bash
tail -f /Library/Logs/Multipass/multipassd.log
```
