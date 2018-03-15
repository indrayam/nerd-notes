# lsof

### Find processes that are listening on a specific port

```bash
lsof -i:8080
lsof -t -i:8080
```

### Kill processes that are listening on a specific port

```bash
kill -9 $(lsof -t -i:8001)
```
