# lsof

### Find processes that are listening on a specific port

`lsof -i:8001`
`lsof -t -i:8001`

### Kill processes that are listening on a specific port

`kill -9 $(lsof -t -i:8001)
