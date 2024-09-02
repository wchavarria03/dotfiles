.PHONY: stow unstow

stow:
	stow . -t ~/

unstow: 
	stow -D . -t ~/
