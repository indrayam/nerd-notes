# operating system scratchpad

### Issues on MacOS X

**Upgrading to Ruby 2.4.1_1 breaks gem command**

```
/usr/local/Cellar/ruby/2.4.1_1/lib/ruby/2.4.0/yaml.rb:5:in `<top (required)>':
It seems your ruby installation is missing psych (for YAML output).
To eliminate this warning, please install libyaml and reinstall your ruby.
```

Solution:

```bash
brew uninstall --ignore-dependencies --force ruby
# Delete psych folders
sudo rm -rf /usr/local/lib/ruby/gems/2.4.0/gems/psych-3.0.*
sudo rm -rf /usr/local/lib/ruby/gems/2.4.0/extensions/x86_64-darwin-16/2.4.0/psych-3.0.*
brew install ruby
```


### Issues on Linux

**Install Fira Code Font**

Solution:

With most desktop-oriented distributions, double-clicking each font file in the ttf folder and selecting “Install font” should be enough. If it isn’t, try this:

1. `mkdir -p ~/.local/share/fonts`
2. `touch download.sh`
 
3.  ```shell
    # In download.sh
    for type in Bold Light Medium Regular Retina; do
        wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
        "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
    done
    ```
4. `bash download.sh`
5. `fc-cache -f`
6. One catch: Since "ligatures" are not supported in Gnome Terminal, `=` sign does not work if you select **Fira Code Regular** as your Terminal font. Decided to revert back to **DejaVu Sans Mono Book** font.
