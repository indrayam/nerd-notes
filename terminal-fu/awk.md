# awk

## Print a. column (but remove the grep command from being included)
- `ps -ef | grep -i kafka | grep -v grep | awk '{ print $2}'`
