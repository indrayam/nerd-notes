# aws sts

Security Token Service (STS) enables you to request temporary, limited-privilege credentials for Identity and Access Management (IAM) users or for users that you authenticate (federated users).

## Get Account ID

```bash
aws sts get-caller-identity --query "Account" --output text
```