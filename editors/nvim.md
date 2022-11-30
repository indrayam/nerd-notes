# nvim

## Setting up nvim

Source: [Turning Neovim into a Full-Fledged Code Editor with Lua](https://mattermost.com/blog/turning-neovim-into-a-full-fledged-code-editor-with-lua/)

1. Create a symlink `~/.config/nvim` that points to `~/Dropbox/workplace/cloud-configurations/nvim`
2. Copy `init-bootstrap.lua` to `init.lua`. If `packer` is not already available in Dropbox `nvim` folder under `site/`, install `packer` using the following command:


```bash
git clone --depth 1 git@github.com:wbthomason/packer.nvim.git ~/.config/nvim/site/pack/packer/start/packer.nvim

```
3. Run `nvim`
4. Run `:PackerInstall`. This should install all the plugins in `~/.local/share/nvim` folder
5. Copy `init-latest.lua` to `init.lua`
6. Run `nvim`