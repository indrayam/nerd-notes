# history

In Zsh, history is aliased to `fc -l 1`. Details [here](https://www-s.acm.illinois.edu/workshops/zsh/history/fc.html)

### List the entire history

```bash
fc -l 1
```

### List the last 16

```bash
fc -l -16 -1
```

### List the history of commands matching a pattern

```bash
fc -l -m 'mk*' 1
```


