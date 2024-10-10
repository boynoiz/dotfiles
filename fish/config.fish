#set PATH
set -gx PATH $HOME/.local/bin /usr/local/bin /usr/share $PATH
set -gx XDG_CONFIG_HOME $HOME/.config

# ASDF
set -l asdf_path $HOME/.asdf

if test -f $asdf_path/asdf.fish
    source $asdf_path/asdf.fish

    if test -d $asdf_path/shims
        fish_add_path $asdf_path/shims
    end
end

# Homebrew
set -l brew_path /home/linuxbrew/.linuxbrew/bin/brew

if test -x $brew_path
    eval ($brew_path shellenv)

    set -l brew_prefix (brew --prefix)
    set -l completion_paths \
        $brew_prefix/share/fish/completions \
        $brew_prefix/share/fish/vendor_completions.d

    for path in $completion_paths
        if test -d $path
            fish_add_path --path $fish_complete_path $path
        end
    end
end

# Ensure asdf shims take precedence
if test -d $asdf_path/shims
    fish_add_path --move --prepend $asdf_path/shims
end

#encoding
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_MESSAGES en_US.UTF-8

# Git GPG Key
set -gx GPG_TTY (tty)

# Windows X-Server
set check_os (uname -r | sed -n 's/.*\( *microsoft *\).*/\1/pi')
if string match -riq 'microsoft' $check_os
  set -gx PATH /c/Windows/System32/ $PATH
  set -gx GDK_SCALE 0
  set -gx GDK_BACKEND x11
  set -gx LIBGL_ALWAYS_INDIRECT 1
  #set -gx NO_AT_BRIDGE 1
  set -gx WSL_HOST_IP (ip route show default | awk '{print $3}')
  set -gx DISPLAY $WSL_HOST_IP:0.0
  set -gx PULSE_SERVER tcp:$WSL_HOST_IP
end

# Start SSH Agent
# https://github.com/ivakyb/fish_ssh_agent
fish_ssh_agent

# Zellij
# if status is-interactive
#   if type -q zellij
# 	  eval (zellij setup --generate-auto-start fish | string collect)
# 	end
# end

# Default Browser
if type -q google-chrome-beta
  set -gx BROWSER /usr/sbin/google-chrome-beta
end

# Starship
if type -q starship
  set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
  starship init fish | source
end

if type -q fzf
	fzf --fish | source 
	if type -q fd
		set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
		set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
	end 
end

# If micro editor exist
if type -q micro
 set -gx KUBE_EDITOR micro
 set -gx TALOS_EDITOR micro
end

# Jetbrains App
if test -d "$HOME/.local/share/JetBrains/Toolbox/scripts"
  set -gx PATH "$HOME/.local/share/JetBrains/Toolbox/scripts" $PATH
end

# PyENV
if type -q python and type -q aria2c
  set -gx PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M"
end

# Kruw
if test -d "$HOME/.krew"
  set -gx PATH $PATH $HOME/.krew/bin
end

# Golang
# No need anymore as asdf will switch go env itself
# if type -q go
#   set -gx GOPATH (go env GOPATH)
#   set -gx GOROOT (go env GOROOT)
#   set -gx GOBIN (go env GOBIN)
#   set -gx PATH $PATH $GOPATH/bin $GOROOT/bin $GOBIN
# end

# Rust
if test -d "$HOME/.cargo/bin"
  set -gx PATH $PATH $HOME/.cargo/bin
end

# The Fuck
if type -q thefuck
  thefuck --alias | source
end

# LDS
if type -q lsd
  alias ls='lsd' $argv
end

# Zoxide
if type -q zoxide
    zoxide init fish | source
end

# VsCode
if type -q code
  set -gx DONT_PROMPT_WSL_INSTALL 1
end

# Tmux Plugin Manager
if test -d "$HOME/.tmux/plugins/"
  set -gx TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins/"
end

if type -q k9s
  set -gx K9SCONFIG $HOME/.config/k9s/
end

# k3d
if type -q k3d
  k3d completion fish | source
end

# mcfly
if type -q mcfly
  mcfly init fish | source
end

if type -q yq
  yq shell-completion fish | source
end

if type -q colima
  colima completion fish | source
end

# MySQL-Client@5.7 By HomeBrew
if test -d "$HOMEBREW_PREFIX/opt/mysql-client@5.7"
  set -gx PATH $PATH $HOMEBREW_PREFIX/opt/mysql-client@5.7/bin
end

# Helm
if type -q helm
  helm completion fish | source
end

# Kompose
if type -q kompose
  kompose completion fish | source
end

# Go Entity Framework
if type -q ent
  ent completion fish | source
end
