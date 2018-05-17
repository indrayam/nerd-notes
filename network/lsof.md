# lsof

### Find processes that are listening on a specific port

```bash
sudo lsof -i:8080
sudo lsof -t -i:8080
```

### Kill processes that are listening on a specific port

```bash
kill -9 $(lsof -t -i:8001)
```
