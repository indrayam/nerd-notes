# vagrant

[Source](https://www.vagrantup.com/intro/getting-started/)

### Install a specific Box

```bash
mkdir ~/vagrant/ubuntu 
vagrant init ubuntu/xenial64
vagrant up
```

### List all the Boxes installed

```bash
vagrant box list
```

### Remove a Box

```bash
vagrant suspend
```

### Remove a Box

```bash
vagrant box remove <name> --box-version <version>
```

### SSH into a Box

```bash
(Make sure you are inside a box folder)
vagrant ssh
```
