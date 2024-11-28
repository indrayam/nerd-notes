# aws budgets

## Get all budgets 

```bash
aws budgets describe-budgets --account-id $(aws sts get-caller-identity --query "Account" --output text) | jq '.Budgets[] | { name: .BudgetName, time: .TimeUnit, type: .BudgetType }'
```

## Get details of a single budgets

```bash
aws describe budget --budget-name "My Monthly Cost Budget" --account-id $(aws sts get-caller-identity --query "Account" --output text)
```