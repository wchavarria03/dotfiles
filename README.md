# dotfiles

Index
- [OhMyZsh Prompt](https://github.com/wchavarria03/dotfiles#OhMyZsh-Prompt)
- [ZSH Config](https://github.com/wchavarria03/dotfiles#zsh-Config)
- [tmux Config](https://github.com/wchavarria03/dotfiles#tmux-Config)
- [nvim Config](https://github.com/wchavarria03/dotfiles#nvim-Config)
- [gitconfig](https://github.com/wchavarria03/dotfiles#gitconfig)

## Font
I am using Fira Code Font https://github.com/tonsky/FiraCode

## Terminal ANSI Colors and Config
- Font Fira Code SemiBold 11pt.
- Background Color: #282D35
- Cursor Color: #FBFCFC

- Font Color: #9CA3B2
- Black 0: #3E4352
- Red 1: #FF5458
- Green 2: #84A86C
- Yellow 3: #E4BD48
- Blue 4: #5D9EE7
- Magenta 5: #C991E1
- Cyan 6: #A969BE
- White 7: #CBD09B

NOTE: Bright colors are the same because I am not using them yet

![Terminal Config](https://github.com/wchavarria03/dotfiles/blob/master/images/TerminalConfig.png)

## OhMyZsh Prompt
I am using the minimal prompt from Jack Harris https://github.com/jackharrisonsherlock/common
But I wanted a previous state of it so I fork the repo and add the small change I want https://github.com/wchavarria03/common

Running the following command would link the common repo to the 'oh-my-zsh' path
```
ln -s <path_to_common_repo>/common.zsh-theme <path_to_home_folder>/.oh-my-zsh/custo/themes/common.zsh-theme
```
Terminal now looks like:

![Common Prompt Terminal](https://github.com/wchavarria03/dotfiles/blob/master/images/CommonPrompt.png)

NOTES:
- I would like to change the files color when running `ls` command but It might require some extra work
- To make the branch color magenta when doing `git status` I had to make a change on the .gitconfig and add the config to use the magenta ANSI color

## zsh Config
```
ln -s <path_to_this_folder>/.zshrc <path_to_home_folder>/.zshrc
```

## tmux Config
Create a symblink from your dotfiles folder to your home config folder
```
ln -s <path_to_this_folder>/tmux.conf <path_to_home_folder>/.tmux.conf
```

## nvim Config
Create a symblink from your dotfiles folder to your home config folder
```
ln -s <path_to_this_folder>/.vimrc <path_to_home_folder>/.vim/vimrc
```

## gitconfig
Create a symblink from your dotfiles folder to your home config folder
```
ln -s <path_to_this_folder>/.gitconfig <path_to_home_folder>/.gitconfig
```

