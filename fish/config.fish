#set PATH
set -gx PATH $HOME/.local/bin /usr/local/bin /usr/share $PATH

# Homebrew & asdf
if type -q /home/linuxbrew/.linuxbrew/bin/brew
	# if asdf exist, then register PATH to asdf first.
	set -gx ASDF_SHIMS_PATH $HOME/.asdf/shims
	set -gx ASDF_FISH_EXEC (brew --prefix asdf)/libexec/asdf.fish
    if test -f $ASDF_FISH_EXEC
        set -gx PATH $ASDF_SHIMS_PATH $PATH
        source $ASDF_FISH_EXEC
    end

  set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
  eval ($HOMEBREW_PREFIX/bin/brew shellenv)
  if test -d "$HOMEBREW_PREFIX/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path $HOMEBREW_PREFIX/share/fish/completions
  end
  if test -d $HOMEBREW_PREFIX/share/fish/vendor_completions.d
    set -gx fish_complete_path $fish_complete_path $HOMEBREW_PREFIX/share/fish/vendor_completions.d
  end
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
  set -gx NO_AT_BRIDGE 1
  set -gx WSL_HOST_IP (ip route show default | awk '{print $3}')
  set -gx DISPLAY $WSL_HOST_IP:0.0
  set -gx PULSE_SERVER tcp:$WSL_HOST_IP
end

# Zellij
if status is-interactive
  if type -q zellij
	  eval (zellij setup --generate-auto-start fish | string collect)
	end
end

# Starship
if type -q starship
  set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
  starship init fish | source
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
if type -q python
  set -gx PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M"
end

# Kruw
if test -d "$HOME/.krew"
  set -gx PATH $PATH $HOME/.krew/bin
end

# Golang
if type -q go
  set -gx GOPATH (go env GOPATH)
  set -gx GOROOT (go env GOROOT)
  set -gx GOBIN (go env GOBIN)
  set -gx PATH $PATH $GOPATH/bin $GOROOT/bin $GOBIN
end

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/pattp/.local/share/google-cloud-sdk/path.fish.inc' ]; . '/home/pattp/.local/share/google-cloud-sdk/path.fish.inc'; end
