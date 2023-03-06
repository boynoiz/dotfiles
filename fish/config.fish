# Homebrew
if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    set -gx LD_LIBRARY_PATH /usr/lib (brew --prefix)/lib $LD_LIBRARY_PATH
    set -gx LDFLAGS "-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib" $LDFLAGS
    set -gx CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include" $CPPFLAGS
    set -gx PKG_CONFIG_PATH "/home/linuxbrew/.linuxbrew/opt/openssl@3/lib/pkgconfig" $PKG_CONFIG_PATH
end

#set PATH
set PATH $HOME/bin $HOME/.local/bin /usr/local/bin /usr/share $PATH

#encoding
set LANG en_US.UTF-8
set LANGUAGE en_US.UTF-8
set LC_ALL en_US.UTF-8
set LC_MESSAGES en_US.UTF-8

# Git GPG Key
set -gx GPG_TTY (tty)

# Windows X-Server
set -gx GDK_SCALE 0
set -gx GDK_BACKEND x11
set -gx LIBGL_ALWAYS_INDIRECT 1
set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

# SSH Agent
# https://github.com/ivakyb/fish_ssh_agent
fish_ssh_agent

# set alias
. ~/.config/fish/alias.fish

# Jetbrains App
if test -d $HOME"/.local/share/JetBrains/Toolbox/scripts"
    set -gx PATH $HOME/.local/share/JetBrains/Toolbox/scripts $PATH
end

# asdf
if test -f (brew --prefix asdf)"/libexec/asdf.fish"
    source (brew --prefix asdf)/libexec/asdf.fish
end

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# Kruw
set -gx PATH $PATH $HOME/.krew/bin

# Golang
set -gx GOPATH (go env GOPATH)
set -gx GOROOT (go env GOROOT)
set -gx GOBIN (go env GOBIN)
set -gx PATH $PATH $GOPATH/bin $GOROOT/bin $GOBIN

# Rust
set -gx PATH $PATH $HOME/.cargo/bin

# Starship
if type -q starship
    starship init fish | source
end

# The Fuck
if type -q thefuck
    thefuck --alias | source
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

# k3d
if type -q k3d
  k3d completion fish | source
end
