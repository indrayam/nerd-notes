# sed

### Make substitutions

```bash
sed -i -- 's/string to replace/string to replace it with/' <filename>
```

### Make substitutions with ENV variables

Source: [Environment variable substitution in sed](https://stackoverflow.com/questions/584894/environment-variable-substitution-in-sed/584926#584926)

```bash
sed -i -- 's/nginx/GCP - '"$HOST"'/' <filename>
# If your environment variable has "/", you should do something like this:
sed -i -- 's#nginx#GCP - '"$PWD"'#' <filename>
```
