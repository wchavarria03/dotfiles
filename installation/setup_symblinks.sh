#!/usr/bin/env bash


# Function to setup symblinks repo
setup_symblinks() {
  echo ${COLOR_GREEN}"Configuring ZSH..${COLOR_REST}"
  echo "${COLOR_GREEN}-ZSH Auto load op_env symlinks${COLOR_REST}"
  ln -s ~/code/dotfiles/.zsh_autoload_functions/env-op ~/.zsh_autoload_functions/env-op

  echo "${COLOR_GREEN}-ZSHR symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/.zshenv ~/.zshenv

  echo "${COLOR_GREEN}-ZSHR symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/zsh/.zshrc ~/.config/zsh/.zshrc

  echo ${COLOR_GREEN}"Configuring Git..${COLOR_REST}"
  echo "${COLOR_GREEN}-Gitconfig symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/.gitconfig ~/.gitconfig

  echo ${COLOR_GREEN}"-Git Ignore Global symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/.gitignore_global ~/.gitignore_global


  echo ${COLOR_GREEN}"Configuring Lua..${COLOR_REST}"
  echo ${COLOR_GREEN}"-Init.lua symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/lua-files/init.lua ~/.config/nvim/init.lua

  echo "${COLOR_GREEN}-Lua folder symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/lua-files/lua ~/.config/nvim/lua
}

setup_symblinks
