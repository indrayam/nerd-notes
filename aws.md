# aws cli
```bash
NAME
       aws -

DESCRIPTION
       The  AWS  Command  Line  Interface is a unified tool to manage your AWS
       services.

SYNOPSIS
          aws [options] <command> <subcommand> [parameters]

       Use aws command help for information on a  specific  command.  Use  aws
       help  topics  to view a list of available help topics. The synopsis for
       each command shows its parameters and their usage. Optional  parameters
       are shown in square brackets.
...
...
```

### Getting help for a sub-command
For example: Here's how you get help for "configure" sub-command

```bash
aws configure help
```

### Show my current configuration

```bash
aws configure list
```

### Get version
```bash
aws --version
```

### To set/reset configuration
Will prompt you to set/reset the values. Hit enter to keep the default

```bash
aws configure
```

### Display the current configuration that is being used

```bash
aws configure list
```
