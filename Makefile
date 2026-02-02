all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.tmux/
	mkdir -p ~/.claude
	mkdir -p ~/.cursor
	mkdir -p ~/.config/amp
	mkdir -p ~/Library/Application\ Support/Cursor/User


	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.config/nvim/init.lua ] || ln -s $(PWD)/init.lua ~/.config/nvim/init.lua
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.config/ghostty/config ] || ln -s $(PWD)/ghostty.config ~/.config/ghostty/config

	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/tmux-dark.conf ] || ln -s $(PWD)/tmux-dark.conf ~/.tmux/tmux-dark.conf
	[ -f ~/.tmux/tmux-light.conf ] || ln -s $(PWD)/tmux-light.conf ~/.tmux/tmux-light.conf

	[ -f ~/.claude/statusline-git.sh ] || ln -s $(PWD)/agent/statusline-git.sh ~/.claude/statusline-git.sh

	[ -d ~/.cursor/skills/ ] || ln -s $(PWD)/agent/skills ~/.cursor/skills
	[ -d ~/.claude/skills/ ] || ln -s $(PWD)/agent/skills ~/.claude/skills
	[ -d ~/.codex/skills/ ] || ln -s $(PWD)/agent/skills ~/.codex/skills

	[ -f ~/.claude/CLAUDE.md ] || ln -s $(PWD)/CLAUDE.md ~/.claude/CLAUDE.md
	[ -f ~/.codex/AGENTS.md ] || ln -s $(PWD)/AGENTS.md ~/.codex/AGENTS.md
	[ -f ~/.cursor/rules ] || ln -s $(PWD)/.cursorrules ~/.cursor/rules

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

	rm -f ~/.tmux.conf
	[ ! -L ~/.claude/statusline-git.sh ] || rm -f ~/.claude/statusline-git.sh
	[ ! -L ~/.cursor/skills/ ] || rm -rf ~/.cursor/skills/
	[ ! -L ~/.claude/skills/ ] || rm -rf ~/.claude/skills/
	[ ! -L ~/.codex/skills/ ] || rm -rf ~/.codex/skills/
	[ ! -L ~/.claude/CLAUDE.md ] || rm -f ~/.claude/CLAUDE.md
	[ ! -L ~/.codex/AGENTS.md ] || rm -f ~/.codex/AGENTS.md
	[ ! -L ~/.cursor/rules ] || rm -f ~/.cursor/rules
	[ ! -L ~/Library/Application\ Support/Cursor/User/settings.json ] || rm -f ~/Library/Application\ Support/Cursor/User/settings.json
	[ ! -L ~/Library/Application\ Support/Cursor/User/keybindings.json ] || rm -f ~/Library/Application\ Support/Cursor/User/keybindings.json


.PHONY: all clean sync 
