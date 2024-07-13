#!/usr/bin/env bash


# Function to setup symblinks repo
setup_symblinks() {
  echo ${COLOR_GREEN}"Configuring Alacritty..${COLOR_REST}"
  echo "${COLOR_GREEN}- alacritty symlinks${COLOR_REST}"
  ln -s ~/code/dotfiles/alacrity ~/.config

  echo ${COLOR_GREEN}"Configuring Zellij..${COLOR_REST}"
  echo "${COLOR_GREEN}- Zellij symlinks${COLOR_REST}"
  ln -s ~/code/dotfiles/zellij ~/.config

  echo ${COLOR_GREEN}"Configuring ZSH..${COLOR_REST}"
  echo "${COLOR_GREEN}- ZSH Auto load op_env symlinks${COLOR_REST}"
  ln -s ~/code/dotfiles/.zsh_autoload_functions/env-op ~/.zsh_autoload_functions/env-op

  echo "${COLOR_GREEN}- ZSHR symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/zsh/zshenv.zsh ~/.zshenv

  echo "${COLOR_GREEN}- ZSHR symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/zsh/zshrc.zsh ~/.config/zsh/.zshrc

  echo ${COLOR_GREEN}"Configuring Git..${COLOR_REST}"
  echo "${COLOR_GREEN}- Gitconfig symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/git/.gitconfig ~/.gitconfig

  echo ${COLOR_GREEN}"- Git Ignore Global symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/git/.gitignore_global ~/.gitignore_global


  echo ${COLOR_GREEN}"Configuring Lua..${COLOR_REST}"
  echo ${COLOR_GREEN}"- Init.lua symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/lua/init.lua ~/.config/nvim/init.lua

  echo "${COLOR_GREEN}- Lua folder symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/lua/lua ~/.config/nvim/lua

  echo ${COLOR_GREEN}"Configuring asdf..${COLOR_REST}"
  echo "${COLOR_GREEN}- asdfrc symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/asdf/.asdfrc ~/.config/asdf/.asdfrc

  echo "${COLOR_GREEN}- tool-versions symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/asdf/.tool-versions ~/.tool-versions

  echo "${COLOR_GREEN}Configuring Tmux ..${COLOR_REST}"
  echo ${COLOR_GREEN}"- tmux.config symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf

  echo ${COLOR_GREEN}"- tmux-plugins symlink${COLOR_REST}"
  ln -s ~/code/tmux-plugins/ ~/.config/tmux

  echo "${COLOR_GREEN}Configuring StarShip ..${COLOR_REST}"
  echo ${COLOR_GREEN}"- starship.toml symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/startship/starship.toml ~/.config/starship/starship.toml

  echo "${COLOR_GREEN}Others ..${COLOR_REST}"
  echo ${COLOR_GREEN}"- go cobra.yaml symlink${COLOR_REST}"
  ln -s ~/code/dotfiles/go/cobra.yml ~/.cobra.yaml
}

setup_symblinks_clean_up() {
  echo "${COLOR_GREEN}Setup symblinks clean up - coming feature...${COLOR_RESET}"
}
