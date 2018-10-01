# Redis Dump

### Install Redis Dump

```bash
sudo npm install redis-dump -g
```

### Dump all the Redis Commands into Text File

```bash
redis-dump > dump.txt
```

OR

```bash
redis-dump --json --pretty > dump.json
```

### Dump a specific key from Redis database

```bash
redis-dump -f "spinnaker:fiat:permissions:jalagars:accounts" --json | jq .
```
