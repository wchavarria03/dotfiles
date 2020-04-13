# dotfiles

## ZSH TERMINAL
I am using the minimal commmont prompt from Jack Harris https://github.com/jackharrisonsherlock/common
But I wanted a previous state of it so I fork the repo and add the small change I want https://github.com/wchavarria03/common

Running the following command would link the common repo to the oh-my-zsh path
```
ln -s <path_to_common_repo>/common.zsh-theme <path_to_home_folder>/.oh-my-zsh/custo/themes/common.zsh-theme
```
Terminal now looks like

![Common Prompt Terminal](https://github.com/wchavarria03/dotfiles/blob/master/images/CommonPrompt.png)

NOTES:
- I would like to change the files color when running `ls` command but It might require some extra work
- To make the branch color magenta when doing `git status` I had to make a change on the .gitconfig and add the config to use the magenta ANSI color

## zsh
```
ln -s <path_to_this_folder>/.zshrc <path_to_home_folder>/.zshrc
```

## tmux
Create a symblink from your dotfiles folder to your home config folder
```
ln -s <path_to_this_folder>/tmux.conf <path_to_home_folder>/.tmux.conf
```

## vimrc
Create a symblink from your dotfiles folder to your home config folder
```
ln -s <path_to_this_folder>/.vimrc <path_to_home_folder>/.vim/vimrc
```

## gitconfig
Create a symblink from your dotfiles folder to your home config folder
```
ln -s <path_to_this_folder>/.gitconfig <path_to_home_folder>/.gitconfig
```

