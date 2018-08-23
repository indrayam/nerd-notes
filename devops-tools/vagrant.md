# vagrant

https://www.vagrantup.com/intro/getting-started/

// Install a specific Box
mkdir ~/vagrant/ubuntu 
vagrant init ubuntu/xenial64
vagrant up

// List all the Boxes installed
vagrant box list

// Remove a Box
vagrant suspend

// Remove a Box
vagrant box remove <name> --box-version <version>

// SSH into a Box
(Make sure you are inside a box folder)
vagrant ssh
