# My Aliases

if type -q exa
    alias ls='exa -lag --header'
end

if type -q z
    alias cd='z'
end

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history'
alias which='type -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ccd='clear && cd'
alias killpyc='find . -name \*.pyc -delete'
alias tmux="tmux -2"
alias latex="docker run -v `pwd`:/tmp latex pdflatex"
