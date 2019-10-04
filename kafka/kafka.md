# kafka

## Installing Kafka on MacOS
[Source](https://medium.com/@Ankitthakur/apache-kafka-installation-on-mac-using-homebrew-a367cdefd273)

Assuming `java` is already installed

```bash
brew install kafka
# Update /usr/local/etc/kafka/server.properties to make sure you use the correct values for
# broker id, port number and logs path. Especially port number
# port number (see below)
# #listeners = PLAINTEXT://your.host.name:9092
# listeners=PLAINTEXT://localhost:9092)
```

## Starting Kafka

```bash
zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties &
kafka-server-start /usr/local/etc/kafka/server.properties &
kafka-server-start /usr/local/etc/kafka/server1.properties &
```
