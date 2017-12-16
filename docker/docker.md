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
docker image ls
docker image ls -a

## Get status of containers
docker container ls 
docker container ls -a
docker ps
docker ps -a
docker ps -l (Show the last container that was run)
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

## Remove docker containers
d rm <container name or uuid>

## Remove all containers
d rm -f `sudo docker ps -a -q`




