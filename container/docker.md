# docker help

### docker login

[Google Cloud Registry Authentication Mechanisms](https://cloud.google.com/container-registry/docs/advanced-authentication)
[Sharing Docker Containers in Google Container Registry](https://medium.com/google-cloud/sharing-docker-containers-in-google-container-registry-1e816b88eae9)

```bash
docker login
docker login -u="<userid>" -p="..." <ech-server-name>
gcloud auth configure-docker # one time only
docker login -u _json_key -p "$(cat ~/.gcp/gce-account.json)" https://us.gcr.io
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
docker pull <ech-server-name>/anasharm/<image-name>:<tag>
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
docker build --no-cache -t kubia .
```

### Tagging Images

```bash
d tag <source-image> <target-image>
```

### docker push

```bash
docker push indrayam/<image-name>:<tag>
gcloud docker -- push us.gcr.io/evident-wind-163400/myhttpd:latest
docker push <ech-server-name>/anasharm/<image-name>:<tag>
```

### Get status of containers

```bash
docker ps
docker ps -a
docker ps -l (Show the last container that was run)
docker ps -n 10 (Shows the last 10 containers, running or stopped)
```

### Start(up) an exited container

```bash
docker start <container name or uuid>
```

### Stop a running container

```bash
# Graceful shutdown of a container
docker stop <container name or uuid>

# Kill the container
docker kill <container name or uuid>
```

### Viewing History

The history command lists all the layers composing an image. For each layer, it shows its creation time, size, and creation command. 

```bash
docker history <image-name>
```

### Finding out more about our container

```bash
docker inspect <container name or uuid>
d inspect --format='{{ .State.Running }}' <container name or uuid>
d inspect --format='{{ .NetworkSettings.IPAddress }}' <container name or uuid>
d inspect --format='{{.Config.ExposedPorts}}' <container name or uuid>
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

To detach the tty without exiting the shell, use the escape sequence Ctrl+p + Ctrl+q followed by Ctrl+C.

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
docker network ls
docker network create dev
docker network rm dev
```

Docker for Mac uses Hyperkit to run a xhyve VM for the Docker daemon. The VM uses VPNKit for exposing container ports to localhost. I was able to use the following command to access the xhyve VM:

```bash
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
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

### .dockerignore

Before the docker CLI sends the context to the docker daemon, it looks for a file named .dockerignore in the root directory of the context. If this file exists, the CLI modifies the context to exclude files and directories that match patterns in it. This helps to avoid unnecessarily sending large or sensitive files and directories to the daemon and potentially adding them to images using ADD or COPY.

[Reference](https://docs.docker.com/engine/reference/builder/#dockerignore-file)

### Dockerfile 

```bash
FROM alpine

# Who is the maintainer of this Dockerfile
LABEL maintainer="Anand Sharma (anand.sharma@gmail.com)"

# Any environment variables
ENV ECHO_RESPONSE Hello

# Setup the image for your purposes
RUN ...

# What is your work directory
WORKDIR

# Use COPY if you want to copy local files/folders to the image 
COPY

# Use ADD if you want to copy something using a URL in which case use ADD
ADD

# Expose Ports
EXPOSE 

# CMD (Shell or Exec form). It can be overwritten by command-line arguments to docker run
CMD ["nginx", "-g", "daemon off;"]
# CMD a b c (Shell form, not prefered)

# ENTRYPOINT (Shell or Exec form). Allows you to run a container as an executable
ENTRYPOINT ["top", "-b"]
# ENTRYPOINT a b c (Shell form, not prefered)
# Use command to pass additional paramters, that can be overridden by command-line params
CMD []
```

### Find out what port is a container mapped to

```bash
docker port <container-name-or-id> 80
```

### Remove a ton of dangling images

```bash
docker image prune
```

Source: [Cindy Sridharan's tweet](https://twitter.com/copyconstruct/status/1134205640035848192)

