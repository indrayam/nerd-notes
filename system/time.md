# time

#### Create Epoch time in Unix

```bash
date +%s
```

#### Convert Epoch time to Human Readable date

```bash
date -r <epoch time in seconds>
```

#### Give me the Epoch time from a Human Readable date

```bash
gdate -d "Oct 1 09:00:00 EDT 2020" +"%s"
```

#### Getting the timezone on a Unix machine

```bash
date +%Z
timedatectl | gawk -F': ' ' $1 ~ /Time zone/ {print $2}'
```


