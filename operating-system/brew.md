# homebrew, brew

## brew commands

```bash
# Dumps a `Brewfile` in the local directory
brew bundle dump 

# Installs all the formulas in the Brewfile
brew bundle install --file <folder-path>/Brewfile

# Help
brew help

# Update my homebrew installation
brew update

# Upgrade Everything
brew upgrade

# Upgrade formula_name
brew upgrade

# Find out what's outdated
brew outdated

# To get a list of all formulas
brew search

# List of installed packages on your machine
brew list

# List of installed packages on your machine
brew list --versions

# Update the links
brew link --overwrite formula_name

# To list all files that would be deleted
brew link --overwrite --dry-run formula_name

# Search for formula
brew search <formula-name>

# Uninstall
brew uninstall <formula-name>
```