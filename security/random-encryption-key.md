# encryption key

### Use random to generate key

```bash
head --bytes 32 /dev/urandom | openssl base64 -e # --bytes NUM means print the first 32 bytes of the file
```
