# aws iam

## Listing IAM entities

```bash
aws iam list-users
aws iam list-groups
aws iam list-roles
aws iam list-role-policies --role-name BrahmaRole
aws iam list-attached-role-policies --role-name BrahmaRole
aws iam list-policies --scope Local
aws iam list-entities-for-policy --policy-arn arn:aws:iam::155633134391:policy/BrahmaPolicy
```

## Get IAM entities

```bash
aws iam get-user --user-name anand
aws iam get-group --group-name Brahma
aws iam get-role --role-name BrahmaRole
aws iam get-role-policy --role-name BrahmaRole
aws iam get-policy --policy-arn arn:aws:iam::155633134391:policy/BrahmaPolicy
aws iam get-policy-version --policy-arn arn:aws:iam::155633134391:policy/BrahmaPolicy --version-id v1
```

## Create Role and use Attached Policy

```bash
# Define Assume Role Policy Document
# Store file as resourcepolicy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": ""
    }
  ]
}

# Create a Role
aws iam create-role --role-name BrahmaRole --assume-role-policy-document file://resourcepolicy.json

# Define a Customer Managed Policy to be attached to a Role (IAM Principal)
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}

# Create a Customer Managed Policy as we want to attach (and not inline) the policy

aws iam create-policy --policy-name BrahmaPolicy --policy-document file://adminpolicy.json

# Attach the Customer Managed Policy to the Role
aws iam attach-role-policy --role-name BrahmaRole --policy-arn arn:aws:iam::155633134391:policy/BrahmaPolicy

# Define a Customer Managed Policy to be attached to the user 
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::155633134391:role/BrahmaRole"
    }
  ]
}

# Create the Customer Managed policy as we want to attach the policy to the user
aws iam create-policy --policy-name AssumeBrahmaPolicy --policy-document file://assumerolepolicy.json

# Attach the Customer Managed policy to the User
aws iam attach-user-policy --user-name oliver --policy-arn arn:aws:iam::155633134391:policy/AssumeBrahmaPolicy

# List Attached User Policies
aws iam list-attached-user-policies --user-name oliver

# Get Attached Policy
aws iam get-policy --policy-arn arn:aws:iam::155633134391:policy/AssumeBrahmaPolicy

# Get a specific version of the Attached Policy
aws iam get-policy-version --policy-arn arn:aws:iam::155633134391:policy/AssumeBrahmaPolicy --version-id v1

# Assume the Role...
aws sts assume-role --role-arn arn:aws:iam::155633134391:role/BrahmaRole --role-session-name oliver-testing --duration-seconds 900
```

## Get Inline Policies for User

```bash

# List User Policies
aws iam list-user-policies --user-name oliver

# Get Inline Policy
aws iam get-user-policy --user-name oliver --policy-name seaz_ec2_access
```

## Get Attached Policies for a Role

```bash
# List inline Role Policies
aws iam list-role-policies --role-name BrahmaRole
aws iam get-role-policy --role-name BrahmaRole --policy-name <Policy-Name>

# List attached Role Policies
aws iam list-attached-role-policies --role-name BrahmaRole

# Get Policy Details using Policy ARN returned from the previous command
aws iam get-policy --policy-arn arn:aws:iam::155633134391:policy/BrahmaPolicy

# Use the version information to get policy details
aws iam get-policy-version --policy-arn arn:aws:iam::155633134391:policy/BrahmaPolicy --version-id v1
```

## Update Assume Role Policy to add new Principals

```bash
aws iam update-assume-role-policy --role-name BrahmaRole --policy-document file://trust-policy.json
```
