<div align="center">

<a href="">
  <img alt="Last commit" src="https://img.shields.io/github/last-commit/wchavarria03/dotfiles?logo=git&style=for-the-badge"/>
</a>

[![](https://img.shields.io/badge/Neovim-0.9+-blueviolet.svg?style=for-the-badge&logo=Neovim)](https://github.com/neovim/neovim)

</div>

# Dev Setup

Index
- [Requirements](https://github.com/wchavarria03/dotfiles#Initial-development-setup)
- [Initial Dev Setup](https://github.com/wchavarria03/dotfiles#Initial-development-setup)
- [Automatic Setup](https://github.com/wchavarria03/dotfiles#Development-setup)
- [Font](https://github.com/wchavarria03/dotfiles#Font)
- [Terminal ANSI Colors and Config](https://github.com/wchavarria03/dotfiles#Terminal-ANSI-Colors-and-Config)
- [OhMyZsh Prompt](https://github.com/wchavarria03/dotfiles#OhMyZsh-Prompt)
- [ZSH Config](https://github.com/wchavarria03/dotfiles#zsh-Config)
- [tmux Config](https://github.com/wchavarria03/dotfiles#tmux-Config)
- [nvim Config](https://github.com/wchavarria03/dotfiles#nvim-Config)
- [gitconfig](https://github.com/wchavarria03/dotfiles#gitconfig)

## Install Xcode
```
$ xcode-select --install
```

## Automatic setup
Run `mac_development_setup.sh` script on the root of this repo by doing
```
$ sh mac_development_setup.sh
````
We need all the symlinks and configuration to be loaded on a new terminal.
You can also reload configs manually or logout/login session.

## Powerlink Config
### Install Meslo Font for Powerlink10k
In the terminal run the folling, accept font installation
```
$ p10k configure
```

## Restart terminal
Get Packer packages loaded
Previous error about colorschema shouldn't be happening anymore

## Git
SSH keys were moved to 1password and sinin commits is now using ssh instead of GPG.

## Terminal ANSI Colors and Config
- MesloLGS NF Bold 12pt.
- Foreground Color: #C7C7C7 ![#C7C7C7](https://placehold.it/15/C7C7C7/000000?text=+)
- Background Color: #282D35 ![#F03C15](https://placehold.it/15/282D35/000000?text=+)
- Selection Color: #C1DDFF ![#C1DDFF](https://placehold.it/15/C1DDFF/000000?text=+)
- Selected Text Color: #000000 ![#000000](https://placehold.it/15/000000/000000?text=+)
- Badge Color: #FF2600 ![#FF2600](https://placehold.it/15/FF2600/000000?text=+)
- Tab Color: Disabled
- Underline Color: Disabled
- Brighten bold text Color: Disabled
- Minimun Contrast: 0

- Cursor Color: #FBFCFC ![#F03C15](https://placehold.it/15/FBFCFC/000000?text=+)
- Cursor Text: #282D35 ![#F03C15](https://placehold.it/15/282D35/000000?text=+)

NORMAL
- Black 0: #3E4352 ![#3E4352](https://placehold.it/15/3E4352/000000?text=+)
- Red 1: #FF5458 ![#FF5458](https://placehold.it/15/FF5458/000000?text=+)
- Green 2: #84A86C ![#84A86C](https://placehold.it/15/84A86C/000000?text=+)
- Yellow 3: #E4BD48 ![#E4BD48](https://placehold.it/15/E4BD48/000000?text=+)
- Blue 4: #5D9EE7 ![#5D9EE7](https://placehold.it/15/5D9EE7/000000?text=+)
- Magenta 5: #C991E1 ![#C991E1](https://placehold.it/15/C991E1/000000?text=+)
- Cyan 6: #45DCC7 ![#45DCC7](https://placehold.it/15/45DCC7/000000?text=+)
- White 7: #CBD09B ![#CBD09B](https://placehold.it/15/CBD09B/000000?text=+)

Bright
- Black 0: #676767 ![#676767](https://placehold.it/15/676767/000000?text=+)
- Red 1: #FF6D67 ![#FF6D67](https://placehold.it/15/FF6D67/000000?text=+)
- Green 2: #5FF967 ![#5FF967](https://placehold.it/15/5FF967/000000?text=+)
- Yellow 3: #FEFB67 ![#FEFB67](https://placehold.it/15/FEFB67/000000?text=+)
- Blue 4: #6871FF ![#6871FF](https://placehold.it/15/6871FF/000000?text=+)
- Magenta 5: #FF76FF ![#FF76FF](https://placehold.it/15/FF76FF/000000?text=+)
- Cyan 6: #5FFDFF ![#5FFDFF](https://placehold.it/15/5FFDFF/000000?text=+)
- White 7: #FFFEFE ![#FFFEFE](https://placehold.it/15/FFFEFE/000000?text=+)

![Terminal Colors](https://github.com/wchavarria03/dotfiles/blob/master/images/config-colors.png)
![Terminal Text](https://github.com/wchavarria03/dotfiles/blob/master/images/config-text.png)


## NOTES:
### OhMyZsh Prompt (NOT AVAILABLE CURRENTLY)
I am using the minimal prompt from Jack Harris https://github.com/jackharrisonsherlock/common
But I wanted a previous state of it so I fork the repo and add the small change I want

Terminal should look like:

![Common Prompt Terminal](https://github.com/wchavarria03/dotfiles/blob/master/images/CommonPrompt.png)

## Screenshots
Alpha Plugin
![Alpha Plugin](https://github.com/wchavarria03/dotfiles/blob/master/images/plugin-alpha.png)

LSP Plugins
![LSP, Snippets and Completion](https://github.com/wchavarria03/dotfiles/blob/master/images/plugins-lsp.png)


Telescope Plugin
![Telescope](https://github.com/wchavarria03/dotfiles/blob/master/images/plugin-telescope.png)

Command Line Plugin
![Command Line Plugin](https://github.com/wchavarria03/dotfiles/blob/master/images/plugin-noise.png)

## Common issues
1. Issues installing brew: You might need an stable connection to do it so if the installment gets interrupted at the middle you might need to uninstall all brew packages and do it again
2. MAC M1 Chips + Brew: Looks like brew new path in M1 Macs is not added by default so we need to add the path following the suggestion after Brew gets installed, and then restart the terminal so the path takes effect. Then run again the install script.
