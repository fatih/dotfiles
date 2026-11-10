DOTFILES := $(CURDIR)
CURSOR_USER := $(HOME)/Library/Application Support/Cursor/User

# Point $(2) at $(1) in this repo. An old or broken link is replaced. An empty
# directory is removed first (fish creates ~/.config/fish/functions on its first
# start). Any other real file or directory is left alone.
link = if [ -d "$(2)" ] && [ ! -L "$(2)" ]; then rmdir "$(2)" 2>/dev/null; fi; \
	if [ -e "$(2)" ] && [ ! -L "$(2)" ]; then \
		echo "skip $(2): it is a real file, move it away and run make sync again"; \
	else \
		ln -sfn "$(DOTFILES)/$(1)" "$(2)"; \
	fi

# Remove $(1) only when it is a link, never a real file.
remove_link = if [ -L "$(1)" ]; then rm -f "$(1)"; fi

all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.config/atuin
	mkdir -p ~/.tmux
	mkdir -p "$(CURSOR_USER)"

	@$(call link,config.fish,$(HOME)/.config/fish/config.fish)
	@$(call link,fish/functions,$(HOME)/.config/fish/functions)
	@$(call link,vimrc,$(HOME)/.vimrc)
	@$(call link,init.lua,$(HOME)/.config/nvim/init.lua)
	@$(call link,tigrc,$(HOME)/.tigrc)
	@$(call link,gitconfig,$(HOME)/.gitconfig)
	@$(call link,agignore,$(HOME)/.agignore)
	@$(call link,ghostty.config,$(HOME)/.config/ghostty/config)
	@$(call link,atuin.config.toml,$(HOME)/.config/atuin/config.toml)

	@$(call link,tmux.conf,$(HOME)/.tmux.conf)
	@$(call link,tmux-dark.conf,$(HOME)/.tmux/tmux-dark.conf)
	@$(call link,tmux-light.conf,$(HOME)/.tmux/tmux-light.conf)

	@$(call link,cursor-settings.json,$(CURSOR_USER)/settings.json)
	@$(call link,cursor-keybindings.json,$(CURSOR_USER)/keybindings.json)

	# don't show last login message
	touch ~/.hushlogin

clean:
	@$(call remove_link,$(HOME)/.config/fish/config.fish)
	@$(call remove_link,$(HOME)/.config/fish/functions)
	@$(call remove_link,$(HOME)/.vimrc)
	@$(call remove_link,$(HOME)/.config/nvim/init.lua)
	@$(call remove_link,$(HOME)/.tigrc)
	@$(call remove_link,$(HOME)/.gitconfig)
	@$(call remove_link,$(HOME)/.agignore)
	@$(call remove_link,$(HOME)/.config/ghostty/config)
	@$(call remove_link,$(HOME)/.config/atuin/config.toml)

	@$(call remove_link,$(HOME)/.tmux.conf)
	@$(call remove_link,$(HOME)/.tmux/tmux-dark.conf)
	@$(call remove_link,$(HOME)/.tmux/tmux-light.conf)

	@$(call remove_link,$(CURSOR_USER)/settings.json)
	@$(call remove_link,$(CURSOR_USER)/keybindings.json)

.PHONY: all clean sync
