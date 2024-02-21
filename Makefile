all: sync

sync:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/alacritty/themes
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/nvim
	mkdir -p ~/.tmux/

	[ -f ~/.config/alacritty/alacritty.toml ] || ln -s $(PWD)/alacritty.toml ~/.config/alacritty/alacritty.toml
	[ -f ~/.config/alacritty/themes/alacritty-gruvbox-dark.toml ] || ln -s $(PWD)/alacritty-gruvbox-dark.toml ~/.config/alacritty/themes/alacritty-gruvbox-dark.toml
	[ -f ~/.config/alacritty/themes/alacritty-gruvbox-light.toml ] || ln -s $(PWD)/alacritty-gruvbox-light.toml ~/.config/alacritty/themes/alacritty-gruvbox-light.toml
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.config/nvim/init.lua ] || ln -s $(PWD)/init.lua ~/.config/nvim/init.lua
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tmux/tmux-dark.conf ] || ln -s $(PWD)/tmux-dark.conf ~/.tmux/tmux-dark.conf
	[ -f ~/.tmux/tmux-light.conf ] || ln -s $(PWD)/tmux-light.conf ~/.tmux/tmux-light.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist ] || ln -s $(PWD)/io.arslan.dark-mode-notify.plist ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

	# don't show last login message
	touch ~/.hushlogin

clean:
	rm -f ~/.vimrc 
	rm -f ~/.config/nvim/init.lua
	rm -f ~/.config/alacritty/alacritty.toml
	rm -f ~/.config/alacritty/themes/alacritty-gruvbox-dark.toml
	rm -f ~/.config/alacritty/themes/alacritty-gruvbox-light.toml
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/
	rm -f ~/.tmux.conf
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.agignore
	rm -f ~/.agignore
	rm -f ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

.PHONY: all clean sync 
