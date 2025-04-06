<div align="center">

<a href="">
  <img alt="Last commit" src="https://img.shields.io/github/last-commit/wchavarria03/dotfiles?logo=git&style=for-the-badge"/>
</a>

[![](https://img.shields.io/badge/Neovim-0.10.1+-blueviolet.svg?style=for-the-badge&logo=Neovim)](https://github.com/neovim/neovim)

</div>

# Dev Setup

Index

- [Requirements](https://github.com/wchavarria03/dotfiles#Requirements)
- [Automatic Setup](https://github.com/wchavarria03/dotfiles#Automatic-setup)
- [Others](https://github.com/wchavarria03/dotfiles#Others)
- [Commonn issues](https://github.com/wchavarria03/dotfiles#Common-issues)

## Pre Install

### Update your mac to latest version

### Install Xcode

```
$ xcode-select --install
```

## Automatic setup

### Pre-install step

zshenv file is required on the user root folder to change the default paths before running the setup script
Restart terminal to get zshenv file applied

Swap mac Caps Lock key with CTRL.

### Install step

Run `install.sh` script on the setup folder

```
$ cd setup
$ chmod +x install.sh
$ ./install.sh
```

We need all the symlinks and configuration to be loaded on a new terminal.
You can also reload configs manually or logout/login session.

### Clean up

Run `clean_up.sh` script on the setup folder [Coming soon..]

```
$ cd setup
$ chmod +x clean_up.sh
$ ./clean_up.sh
```

## Others

### Git

SSH keys were moved to 1password and signin commits is now using ssh instead of GPG.
SSH keys needs to be added on github account as Authentication Keys and Signing keys

### Secrets

Personal and job related secrets are managed on a private repo

## Common issues

1. Issues installing brew: You might need an stable connection to do it so if the installment gets interrupted at the middle you might need to uninstall all brew packages and do it again
2. MAC M1 Chips + Brew: Looks like brew new path in M1 Macs is not added by default so we need to add the path following the suggestion after Brew gets installed, and then restart the terminal so the path takes effect. Then run again the install script.

# Post Install

## Run stow

```
$ make stow
```

## Asdf

### Install asdf plugins

Install the pending plugins first

```
$ asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

$ asdf plugin add python https://github.com/asdf-community/asdf-python.git

$ asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

$ asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

$ asdf install # installs everything listed on the .tools-versions

```

## Ruftop for cargo and mason package installs
```
$ rustup default stable

$ echo 'export PATH="/opt/homebrew/opt/rustup/bin:$PATH"' >> /Users/wchavarria/.config/zsh/.zshrc

$ rustup-init
```

## Login to 1password

- Enable the 1password cli on the Desktop app
- Run `op signin` on your terminal (maybe not needed since it was added to the .zshrc)
- Make sure your ssh key is already stored on 1password.

## Brew

### Link Brew completions by running

`brew completions link`

## TODOS / Improvements

### TO IGNORE WITH CTR-P on NVIM

- config/zsh/.zsh_sessions
- Almost the same as the stow ignore file
