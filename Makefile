.DEFAULT_GOAL := help
.PHONY: help

bootstrap: ## Bootstrap new machine from scratch
	@echo "Bootstrapping Pattp' new machine, hold tight..."
	@scripts/setup all

clean: ## Uninstalls packages and clean up
	@echo "Cleaning up..."
	@scripts/cleanup all

help: ## This help.
	@printf "\033[36m%-30s\033[0m %s\n" "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

backup:
	@echo "Create installation backup list for Pacman, and Homebrew"
	sudo pacman -Qqe | tee ~/.dotfiles/pacListWSL.txt
	brew bundle dump
