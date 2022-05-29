# neosolarized-patched

This is a theme plugin for NeoVim that combines the work from several other Solarized color schemes with some modifications that make the dark scheme look better on transparent backgrounds.

## Features

* TrueColor support for terminal, and works well in NeoVim GUI.
* Defines color for neovim's embedded terminal.
* Defines colors for several common NeoVim plugins, including TreeSitter and CMP

## Requirements

* NeoVim with package support (`nvim -c "echo has('packages')" -c qa` should report `1`)
* [ColorBuddy](https://github.com/tjdevries/colorbuddy.nvim)

For best results, ensure your terminal emulator supports TrueColor. I've tested this with [Alacritty](https://github.com/alacritty/alacritty) both with and without [TMUX](https://github.com/tmux/tmux/wiki) and with [kitty](https://sw.kovidgoyal.net/kitty/). There are probably other terminals that can do this as well, but I have not personally configured them for it.

## Installation

### Packer (recommended)
If you nave not installed [Packer](wbthomason/packer.nvim) yet, follow the directions to installed it. Then, put the following somewhere in your Packer configuration:
```
use {
    'deriamis/neosolarized-patched.nvim'
    requires = { 'tjdevries/colorbuddy.nvim' }
}
```

If you don't have Packer configured to auto-update after saving, run `:PackerSync` to finish the installation.

### vim-plug
Make sure vim-plug is installed and then put the following before the `call plug#end()` line after [ColorBuddy](https://github.com/tjdevries/colorbuddy.nvim) is loaded:
```
Plug 'deriamis/neosolarized-patched.nvim'`
```
Exit NeoVim and run `nvim --headless +PlugInstall +qa` to complete the installation.

### Vundle
First, install [Vundle](https://github.com/VundleVim/Vundle.vim) and then place the following before `call vundle#end()` and after [ColorBuddy](https://github.com/tjdevries/colorbuddy.nvim) is loaded:
```
Plugin 'deriamis/neosolarized-patched.nvim'
```
Exit NeoVim and run `nvim --headless +PluginInstall +qa` to complete the installation.

### Manual

If don't use or don't wish to use a package manager, you can simply clone the repository into your NeoVim packages directory:
```
git clone https://github.com/deriamis/neosolarized-patched.nvim.git "${XDG_DATA_HOME}/nvim/site/pack/neosolarized-patched.nvim"
```
Be sure you have also installed [ColorBuddy](https://github.com/tjdevries/colorbuddy.nvim) as well.
