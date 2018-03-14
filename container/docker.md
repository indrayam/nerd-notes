# docker help
Usage:  docker COMMAND

A self-sufficient runtime for containers

## Get version
docker version

## Get info
docker info

## Run Docker container with an interactive shell
docker run -i -t ubuntu /bin/bash
docker run --name cda-web-app -i -t /bin/bash
docker run -i -t alpine /bin/sh
docker run --name cda-web-app -i -t alpine /bin/sh

## Get status of images
docker images ls
docker images ls -a

## Get status of containers
docker container ls 
OR
docker ps
docker container ls -a
OR
docker ps -a
docker container ls -l (Show the last container that was run)
OR
docker ps -l (Show the last container that was run)
docker container ls -n 10 (Shows the last 10 containers, running or stopped)
OR
docker ps -n 10 (Shows the last 10 containers, running or stopped)

## Start(up) an exited container
docker start <container name or uuid>

## Stop a running container
docker stop <container name or uuid>

## Attach to a container that has been started up. ***Hit Enter twice to get the prompt***
docker attach <container name or uuid> 

## Logs
docker logs <container name or uuid>
docker logs --tail 10 -f <container name or uuid>
docker logs -f -t <container name or uuid>

## top results. It was not very impressive though
docker top <container name or uuid>
docker stats <container name or uuid> <container name or uuid>...

## finding out more about our container
docker inspect <container name or uuid>
d inspect --format='{{ .State.Running }}' anand-ubuntu-d
OR
d inspect anand-ubuntu-d | jq '.[0].State.Running'
d inspect --format='{{ .NetworkSettings.IPAddress }}' anand-ubuntu-d
OR
d inspect anand-ubuntu-d1 | jq '.[0].NetworkSettings.IPAddress'
d inspect --format '{{ .Name }} {{ .State.Running }}' anand-ubuntu-d anand-ubuntu-d1 anand-ubuntu modest_lovelace
OR
d inspect --format '{{ .Name }} {{ .State.Running }}' $(docker container ls -q -a)

## Remove docker containers
d rm <container name or uuid>

## Remove all containers
d rm -f $(docker ps -a -q)
OR
d rm -f $(docker container ls -a -q)

## Build Images using commit
d stop <container name or uuid>
d commit <container name or uuid> <repository[:tag]>
d images

## Tagging Images
d tag <source-image> indrayam/<target-image>

## docker login
docker login
OR
docker login -u="<userid>" -p="..." containers.cisco.com
OR
docker login -u oauth2accesstoken -p "$(gcloud auth application-default print-access-token)" https://us.gcr.io

## docker push/pull
docker push indrayam/<image-name>:<tag>
docker pull indrayam/<image-name>:<tag>
gcloud docker -- push us.gcr.io/evident-wind-163400/myhttpd:latest
gcloud docker -- pull us.gcr.io/evident-wind-163400/myhttpd:latest
docker push containers.cisco.com/anasharm/<image-name>:<tag>
docker pull containers.cisco.com/anasharm/<image-name>:<tag>

## docker build
docker build . -t <tag-name>
docker build . -t indrayam/helloworld

## docker network
docker network create --driver bridge <network-name>

## sprucing up debian stretch based nginx image 
apt-get update
apt-get install vim net-tools procps
