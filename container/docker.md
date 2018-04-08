# docker help

### Get version

```bash
docker version
```

### Get info

```bash
docker info
```

### docker login

```bash
docker login
docker login -u="<userid>" -p="..." containers.cisco.com
gcloud auth docker-configure # one time only
```

### docker pull

```bash
docker pull indrayam/<image-name>:<tag>
gcloud docker -- pull us.gcr.io/evident-wind-163400/myhttpd:latest
docker pull containers.cisco.com/anasharm/<image-name>:<tag>
```

### Get status of images

```bash
docker images
docker images ls
docker images -a
docker images ls -a
```

### docker build

```bash
docker build -t kubia .
docker build -t indrayam/kubia .
```

### Tagging Images

```bash
d tag <source-image> indrayam/<target-image>
```

### Run Docker container with an interactive shell

```bash
docker run --name kubia -p 8080:8080 -d indrayam/kubia
docker exec -it kubia /bin/bash
```

### docker push

```bash
docker push indrayam/<image-name>:<tag>
gcloud docker -- push us.gcr.io/evident-wind-163400/myhttpd:latest
docker push containers.cisco.com/anasharm/<image-name>:<tag>
```

### Get status of containers

```bash
docker container ls 
docker ps
docker container ls -a
docker ps -a
docker container ls -l (Show the last container that was run)
docker ps -l (Show the last container that was run)
docker container ls -n 10 (Shows the last 10 containers, running or stopped)
docker ps -n 10 (Shows the last 10 containers, running or stopped)
```

### Start(up) an exited container

```bash
docker start <container name or uuid>
```

### Stop a running container

```bash
docker stop <container name or uuid>
```

### Finding out more about our container

```bash
docker inspect <container name or uuid>
d inspect --format='{{ .State.Running }}' anand-ubuntu-d
d inspect anand-ubuntu-d | jq '.[0].State.Running'
d inspect --format='{{ .NetworkSettings.IPAddress }}' anand-ubuntu-d
d inspect anand-ubuntu-d1 | jq '.[0].NetworkSettings.IPAddress'
d inspect --format '{{ .Name }} {{ .State.Running }}' anand-ubuntu-d anand-ubuntu-d1
d inspect --format '{{ .Name }} {{ .State.Running }}' $(docker container ls -q -a)
```

### Remove all containers

```bash
d rm <container name or uuid> #Remove a container
d rm -f $(docker ps -a -q) #Remove all
```

### Remove all images

```bash
d rmi -f $(docker image -a -q)
```

### Attach to a container that has been started up. ***Hit Enter twice to get the prompt***

```bash
docker attach <container name or uuid> 
```

### Logs

```bash
docker logs <container name or uuid>
docker logs --tail 10 -f <container name or uuid>
docker logs -f -t <container name or uuid>
```

### Build Images using commit

```bash
d stop <container name or uuid>
d commit <container name or uuid> <repository[:tag]>
d images
```

### Top results. It was not very impressive though

```bash
docker top <container name or uuid>
docker stats <container name or uuid> <container name or uuid>...
```

### Docker network

```bash
docker network create --driver bridge <network-name>
```

### Sprucing up debian stretch based nginx image 

```bash
apt-get update
apt-get install vim net-tools procps
```
