all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.tmux/
	mkdir -p ~/.claude
	mkdir -p ~/Library/Application\ Support/Cursor/User


	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.config/nvim/init.lua ] || ln -s $(PWD)/init.lua ~/.config/nvim/init.lua
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.config/ghostty/config ] || ln -s $(PWD)/ghostty.config ~/.config/ghostty/config

	[ -f ~/.config/zed/settings.json ] || ln -s $(PWD)/zed-config.json ~/.config/zed/settings.json
	[ -f ~/.config/zed/keymap.json ] || ln -s $(PWD)/zed-keymap.json ~/.config/zed/keymap.json
	[ -f ~/.config/zed/tasks.json ] || ln -s $(PWD)/zed-tasks.json ~/.config/zed/tasks.json

	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/tmux-dark.conf ] || ln -s $(PWD)/tmux-dark.conf ~/.tmux/tmux-dark.conf
	[ -f ~/.tmux/tmux-light.conf ] || ln -s $(PWD)/tmux-light.conf ~/.tmux/tmux-light.conf

	[ -d ~/.claude/commands/ ] || ln -s $(PWD)/claude/commands ~/.claude/commands
	[ -f ~/.claude/statusline-git.sh ] || ln -s $(PWD)/claude/statusline-git.sh ~/.claude/statusline-git.sh
	[ -f ~/.claude/settings.json ] || ln -s $(PWD)/claude/settings.json ~/.claude/settings.json

	[ -f ~/Library/Application\ Support/Cursor/User/settings.json ] || ln -s $(PWD)/cursor-settings.json ~/Library/Application\ Support/Cursor/User/settings.json
	[ -f ~/Library/Application\ Support/Cursor/User/keybindings.json ] || ln -s $(PWD)/cursor-keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json

	# don't show last login message
	touch ~/.hushlogin

clean:
	rm -f ~/.vimrc 
	rm -f ~/.config/nvim/init.lua
	rm -f ~/.config/fish/config.fish
	rm -rf ~/.config/fish/functions/
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.agignore
	rm -f ~/.config/ghostty/config
	rm -f ~/.config/zed/settings.json
	rm -f ~/.config/zed/keymap.json
	rm -f ~/.config/zed/tasks.json
	rm -f ~/.tmux.conf
	rm -rf ~/.claude/commands/
	rm -f ~/.claude/statusline-git.sh
	rm -f ~/.claude/settings.json
	rm -f ~/Library/Application\ Support/Cursor/User/settings.json
	rm -f ~/Library/Application\ Support/Cursor/User/keybindings.json


.PHONY: all clean sync 
