# Nerd Notes

The first computing machine/operating system that I fell in love with was an __SGI/Irix__ pair. It was a beauty! This was during the Summer break of 1996. Times were simpler. Or so it seemed. I had barely completed my first year as a Graduate student in the [Ira Fulton School of Engineering at Arizona State](https://explore.engineering.asu.edu/graduate-degrees/). I was definitely a rookie when it came to all things IT, particularly Unix machines. As you can imagine, getting the prized possesion of working solely on this SGI machine was as close to being in the "Geek Heaven" as I had ever come till that point in my life. It was certainly not going to be my last :wink:

It's somewhat ironical that despite being face-to-face with such an _awesome machine_ which was the premier provider of Unix-based GUI experience, my favorite aspect of that machine was the "terminal". I spent most of my time inside a terminal. I absolutely loved the simplicity and power that came with it.

Fast-forward two decades and a couple of years, and my love for command-line continues unabated. Except now, I like to use the power of the command line utilities to manage not one, but many _many_ __"machines in the cloud".__

This repo is my scratchpad, my notes as I continue to dabble with some old, and mostly newer, command-line beauties.

:smiley: :heart:

## Command Line Tinkerer

### CLI Deep-Dive
- `aws`
- `jq` 
- `curl`, `http`
- `fzf`
- `rg`

### Hands-On Tinkering

- terminal hacks
  - `warp` (or `iterm2`)
  - `oh-my-zsh`
    - starship.toml
  - `ssh`
    - `ssh-keygen -t rsa -b 4096 -C your@email.com -f id_myidentity` (Note: RSA is not the most secure and fast performing algorithm these days)
  - `tmux`
  - `gpg`
    - Install public gpg key: `wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg`
    - Verify fingerprint: `gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint`
- package management
  - `brew`
  - `dpkg`
    - `dpkg --print-architecture`
  - `apt` or `apt-get`
    - `apt-cache` (`apt-cache search` or `apt-cache show`)
    - `/usr/share/keyrings` (contains pgp keys). So does /etc/apt/keyrings. Not sure when to use which. Docker use the latter, while Hashicorp Vault and Docker used the former
    - `/etc/apt/sources.list.d` (contains apt repository details)
  - `tar`
    - `tar -xf...`
  - `mktemp`
- system
  - `sudo adduser`
  - `sudo groupadd docker`
  - `sudo usermod -aG docker $USER`
    - `sudo exec -l $USER # for group membership to take effect immediately`
  - `id $USER` (to find all groups a user belongs to)
  - `sudo visudo`
  - `cpuinfo`
  - `free`
  - `service`
  - `systemctl`
  - `lsb_release`
    - `cat /etc/os-release`
  - `uname`
- networking
  - `ip`
  - `dig`
- performance
  - `iostat`
  - `stress`
  - `top`
  - `trace`
  - `wrk`
- security
  - `vault`
- text wrangling
  - `tee`
  - `xargs`
  - `fzf`
  - `ripgrep`
  - `fd-find`
  - `batcat` (or `bat`)
- http wrangling
  - `jq`
  - `ijq` (interactive jq)
  - `jp` (jmespath on cli)
  - jsoncrack (web app)
  - `curl`
  - `http`
- devops
  - `code`
  - `neovim`
    - iterm2 based copy-paste did not work
    - set relativenumber number signcolumn=yes
  - `git`
    - git aliases for git-fu commands (sync, etc.)
  - `gh`
  - `jf`
  - `make`
- services/platforms
  - containers/container orchestrators
    - `podman`
    - `kubectl`
    - `kubectx`
    - `stern`
    - `arkade` or `helm`
    - `minikube` or `k3s` or `k3d`
  - proxies
    - apache
    - nginx
    - haproxy
    - pingora (cloudflare)
    - `caddy` (for https dev/test locally)
      - `mkcert` (for https dev/test locally)
  - static site
    - `hugo`
    - tailwindcss
