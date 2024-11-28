# aws ssm

## Start a session

```bash
# Connect to an EC2 instance using EC2 Instance Connect and SSM Session Manager
aws ssm start-session --target i-xxx
# Or
ssh i-xxx
```