# sfdx

### Random Musings

- Orgs are not something that you commonly create using `sfdx` other than scratch orgs
- You do not use `sfdx:org:delete` to disconnect from orgs
- You use `sfdx auth:logout -u <username>` to logout
- You create local project settings like `defaultusername` or `defaultdevhubusername` using `sfdx config:set` commands. To create a global setting, you pass a `-g` option to the end of `sfdx config:set`

### Get version

```bash
sfdx version
```

### Update CLI

```bash
sfdx update
```

### Get Help on Command Options

```bash
# For best help results, use the command below
sfdx help force:project:create
# OR
sfdx force:project:create -h
```

### Create SFDX Project

```bash
sfdx force:project:create --projectname ps1
```

### List all Orgs

```bash
sfdx force:org:list
# The following will clean deleted orgs
sfdx force:org:list --clean --noprompt --all
```

### Log into a Developer/Sandbox Org as Dev Hub

Notice the use of `-d` or `--defaultdevhubuser`
```bash
sfdx auth:web:login --setdefaultdevhubuser --setalias <org-alias>
# 
sfdx auth:web:login -d --setalias <org-alias>
```

You can make an existing org a default Dev Hub user by running:

```bash
sfdx config:set defaultdevhubusername=<org-alias>
```

### Log into a Developer/Sandbox Org 

Notice the use of `-s`. It's the most flexible way to authenticate to an existing org.

```bash
sfdx auth:web:login -s
```

Another way to achieve the same thing would be to set the `--defaultusername` config for the project

```bash
sfdx config:set defaultusername=<org-alias>
```

After running either of these two commands shown above, running the `sfdx force:org:list` will show a `(U)` next to the Org alias that is being used as the "default user".

### Logout from a connected Org

```bash
sfdx auth:logout -u <org-alias>
```

### Unset/Remove the alias of an existing Org

```bash
sfdx alias:unset <alias-name>
```

### Set alias for an existing Org

```bash
sfdx alias:set <org-alias>=<org-username>
```

### Use Dev Hub Org to create Scratch Orgs

```bash
sfdx force:org:create -f config/project-scratch-def.json --setalias <org-alias> --durationdays 7 --setdefaultusername
# OR
sfdx force:org:create -f config/project-scratch-def.json --setalias <org-alias> --durationdays 7 -s
```

### Delete Org

```bash
sfdx force:org:delete -u <org-alias>
```

### Open the Default Org

```bash
sfdx force:org:open
```

### Generate password for Scratch Org user

```bash
sfdx force:user:password:generate
# aqjr!0fUwuhcn
# 
```

### Display User Info

```bash
sfdx force:user:display -u <scratch-alias>
# OR
# sfdx force:user:display -u test-mizjbqfau4o6@example.com
```
