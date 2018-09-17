# docker help

### docker login

```bash
docker login
docker login -u="<userid>" -p="..." containers.cisco.com
gcloud auth configure-docker # one time only
# aws ecr command prints out the docker login command that lasts for 12 hrs
eval $(aws ecr get-login --no-include-email --region us-east-1)
```

### Run Docker container with an interactive shell

`docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`

where,

- `--rm` Automatically remove the container when it exits
- `-t | --tty` Allocate a pseudo-TTY
- `-i | --interactive` Keep STDIN open even if not attached
- `-d | --detach` Run container in background and print container ID
- `--name` Assign a name to the container
- `-p | --publish` Publish a container's port(s) to the host
- `-v | --volume` Bind mount a volume
- `-w | --workdir` Working directory inside the container
- `--env` Define environment variables
- `--link` Add link to another container. Format: other-container-name-or-id:alias


```bash
docker run \
  --rm \
  --tty \
  --interactive \
  --detach \
  --name my_container \
  --publish 3000:3000 \
  --volume /my_volume \
  --workdir /app \
  IMAGE bash

docker run -i -t --rm --name ubuntu ubuntu bash
docker run -i -t --rm --name alpine alpine ash

docker run -d --name nginx -p 8080:80 nginx
docker run -d --name httpd -p 8081:80 httpd
docker run -d --name redis -p 6379:6379 redis
docker run -d --name mongo -p 27017:27017 mongo
docker run -d --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=test1234 postgres
docker run -d --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=test1234 mariadb

```

### Get version

```bash
docker version
```

### Get info

```bash
docker info
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
d tag <source-image> <target-image>
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

# To get a list of all the containers along with their current running state
d inspect --format '{{ .Name }} {{ .State.Running }}' $(docker container ls -q -a)
# To get a list of all the containers along with the complete command
d inspect --format "{{.Name}}  {{.Config.Cmd}}" $(docker ps -a -q)
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
# - dnsutils (nslookup)
# - net-tools (netstat, ifconfig, etc.)
# - iproute2 (ip)
# - iputils-ping (ping)
# - iputils-tracepath (traceroute6)
# - proccps (ps)
apt-get update
apt-get install vim net-tools procps iputils-ping dnsutils iproute2 iputils-tracepath

```
