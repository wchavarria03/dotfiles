# Dev Setup

Index
- [Initial Dev Setup](https://github.com/wchavarria03/dotfiles#Initial-development-setup)
- [Development Setup](https://github.com/wchavarria03/dotfiles#Development-setup)
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

## Development setup
Run `mac_development_setup.sh` script on the root of this repo by doing
```
$ sh mac_development_setup.sh
````
We need all the symlinks and configuration to be loaded on a new terminal.
You can also reload configs manually or logout/login session.

## Lua Packer

### Open Nvim
You might get an error about a colorschema missing, you can ignore while we run Packer on the follwing step.

### Run Packer to install Lua Packages
Into Nvim run the following commands
```
:PackerInstall
```
Close nvim

## Powerlink Config
### Install Meslo Font for Powerlink10k
In the terminal run the folling, accept font installation
```
$ p10k configure
```

### Spurce powerlink10k config
Add the following line to .zshrc file
```
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
```

## Restart terminal
Get Packer packages loaded
Previous error about colorschema shouldn't be happening anymore

## Git
Gitconfig requires to replace the gpgp signing key
```
[user]
  signingkey = <GPG Sign Key>
```

## Bash completion
Add the following line to the .bash_profile
```
[[ -r \"/usr/local/etc/profile.d/bash_completion.sh\" ]] && . \"/usr/local/etc/profile.d/bash_completion.sh
```

## Zsh Completion
Add the following lines to .zshrc
```
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
```
You may also need to force rebuild `zcompdump`:

```
  rm -f ~/.zcompdump; compinit
```

Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting
to load these completions, you may need to run this:

```
  chmod -R go-w '/usr/local/share/zsh'
```

## Terminal ANSI Colors and Config
- Font Fira Code SemiBold 11pt.
- Background Color: #282D35 ![#f03c15](https://placehold.it/15/282D35/000000?text=+)
- Cursor Color: #FBFCFC ![#f03c15](https://placehold.it/15/FBFCFC/000000?text=+)
- Cursor Text: #282D35 ![#f03c15](https://placehold.it/15/282D35/000000?text=+)

- Font Color: #9CA3B2 ![#9CA3B2](https://placehold.it/15/9CA3B2/000000?text=+)
- Black 0: #3E4352 ![#3E4352](https://placehold.it/15/3E4352/000000?text=+)
- Red 1: #FF5458 ![#FF5458](https://placehold.it/15/FF5458/000000?text=+)
- Green 2: #84A86C ![#84A86C](https://placehold.it/15/84A86C/000000?text=+)
- Yellow 3: #E4BD48 ![#E4BD48](https://placehold.it/15/E4BD48/000000?text=+)
- Blue 4: #5D9EE7 ![#5D9EE7](https://placehold.it/15/5D9EE7/000000?text=+)
- Magenta 5: #C991E1 ![#C991E1](https://placehold.it/15/C991E1/000000?text=+)
- Cyan 6: #A969BE ![#A969BE](https://placehold.it/15/A969BE/000000?text=+)
- White 7: #CBD09B ![#CBD09B](https://placehold.it/15/CBD09B/000000?text=+)

NOTE: Bright colors are the same because I am not using them yet

![Terminal Config](https://github.com/wchavarria03/dotfiles/blob/master/images/TerminalConfig.png)


## NOTES:
### OhMyZsh Prompt (NOT AVAILABLE CURRENTLY)
I am using the minimal prompt from Jack Harris https://github.com/jackharrisonsherlock/common
But I wanted a previous state of it so I fork the repo and add the small change I want

Terminal should look like:

![Common Prompt Terminal](https://github.com/wchavarria03/dotfiles/blob/master/images/CommonPrompt.png)

NOTES:
- I would like to change the files color when running `ls` command but It might require some extra work
- To make the branch color magenta when doing `git status` I had to make a change on the .gitconfig and add the config to use the magenta ANSI color

