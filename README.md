# dotfiles

Index
- [Font](https://github.com/wchavarria03/dotfiles#OhMyZsh-Prompt)
- [Terminal ANSI Colors and Config](https://github.com/wchavarria03/dotfiles#Terminal-ANSI-Colors-and-Config)
- [OhMyZsh Prompt](https://github.com/wchavarria03/dotfiles#OhMyZsh-Prompt)
- [ZSH Config](https://github.com/wchavarria03/dotfiles#zsh-Config)
- [tmux Config](https://github.com/wchavarria03/dotfiles#tmux-Config)
- [nvim Config](https://github.com/wchavarria03/dotfiles#nvim-Config)
- [gitconfig](https://github.com/wchavarria03/dotfiles#gitconfig)

## Font
I am using Fira Code Font https://github.com/tonsky/FiraCode

## Terminal ANSI Colors and Config
- Font Fira Code SemiBold 11pt.
- Background Color: #282D35 ![#f03c15](https://placehold.it/15/282D35/000000?text=+)
- Cursor Color: #FBFCFC ![#f03c15](https://placehold.it/15/282D35/000000?text=+)

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

