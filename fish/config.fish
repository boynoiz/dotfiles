#set PATH
set PATH $HOME/bin $HOME/.local/bin /usr/local/bin /usr/share $PATH

# Fish addition functions
if test -d $HOME/.dotfiles/fish/functions
  set -gx fish_function_path $fish_function_path "$HOME/.dotfiles/fish/functions"
end

# Fish shell autocompletions
if test -d $HOME/.dotfiles/fish/completions
  set -gx fish_complete_path $fish_function_path "$HOME/.dotfiles/fish/completions"
end

# Homebrew
if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    #set -gx LD_LIBRARY_PATH /usr/lib (brew --prefix)/lib $LD_LIBRARY_PATH
    #set -gx LDFLAGS "-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib" $LDFLAGS
    #set -gx CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include" $CPPFLAGS
    #set -gx PKG_CONFIG_PATH "/home/linuxbrew/.linuxbrew/opt/openssl@3/lib/pkgconfig" $PKG_CONFIG_PATH
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
  set -gx GDK_SCALE 0
  set -gx GDK_BACKEND x11
  set -gx LIBGL_ALWAYS_INDIRECT 1
  set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
end

# asdf
if test -f (brew --prefix asdf)"/libexec/asdf.fish"
    source (brew --prefix asdf)/libexec/asdf.fish
end

# Jetbrains App
if test -d $HOME"/.local/share/JetBrains/Toolbox/scripts"
    set -gx PATH $HOME/.local/share/JetBrains/Toolbox/scripts $PATH
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
  set -gx _ZO_ECHO 1
  zoxide init --cmd cd --hook pwd fish | source
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

# mcfly
if type -q mcfly
  mcfly init fish | source
end

# set alias
if test -f $HOME/.dotfiles/fish/alias.fish
  source $HOME/.dotfiles/fish/alias.fish
end
