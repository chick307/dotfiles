_which() { which $@ 2> /dev/null; }

[[ -z $GOPATH ]] && . .profile

# shell
export HISTSIZE=2000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth
export HISTIGNORE=exit:ls
shopt -s extglob
shopt -s globstar
shopt -s checkjobs
shopt -s histappend
shopt -s checkwinsize

# editor
export EDITOR=vim

# pager
export PAGER=less
export LESS=-cRS

# lesspipe
[ -x "$(_which lesspipe)" ] && eval "$(SHELL=/bin/sh lesspipe)"

# dircolors
if [ -x "$(_which dircolors)" ]; then
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# prompt
update-ps1() { export PS1='\h:\w $ '; }
export PROMPT_COMMAND="update-ps1"

# powerline
if [[ "$(_which powerline-shell)" ]]; then
    update-ps1-powerline() { export PS1="$(powerline-shell)"; }
    export PROMPT_COMMAND="update-ps1-powerline"
fi

# direnv
[ -x "$(_which direnv)" ] && eval "$(direnv hook bash)"

# ls
case "${OSTYPE}" in
    darwin*)
        alias ls='ls -G'
        alias ll='ls -G -alF'
        alias la='ls -G -A'
        ;;
    linux*)
        alias ls='ls --color=auto --group-directories-first'
        alias ll='ls --color=auto --group-directories-first -alF'
        alias la='ls --color=auto --group-directories-first -A'
        ;;
esac

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git
alias gti=git
peco-git-refs() { git for-each-ref --format='%(refname)' refs/{heads,tags,remotes} | grep -v '^refs/remotes/.*/HEAD$' | sed -e 's@^refs/\(heads\|remotes\|tags\)/@@' | peco --query "$*"; }
export DIFF_HIGHLIGHT=$(_which diff-highlight || _which cat)
[[ ! -x $(_which diff-highlight) && -x $(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight ]] && ln -sfn "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/.local/bin/ && export DIFF_HIGHLIGHT=$(_which diff-highlight)

# bash completion
[ -x "$(_which brew)" ] && [ -f "$(brew --prefix)/etc/bash_completion" ] && \
    . "$(brew --prefix)/etc/bash_completion"

# history
[[ -n $SSH_CONNECTION && -z $SSH_TTY ]] || bind -x '"\C-r": readline-peco-history'
peco-history() { HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE"; }
readline-peco-history() { declare l=$(peco-history "$READLINE_LINE"); READLINE_LINE="$l"; READLINE_POINT=${#l}; }

# ghq
peco-ghq() { ghq list -p | peco --query "$*"; }

# cd
cdq() { local nwd="`peco-ghq $@`"; [ -n "$nwd" ] && echo ">> cd \"$nwd\"" && cd "$nwd"; }

# ps
peco-ps() { ps aux | peco --query "$*" | awk '{ print $2 }'; }

# kill
killp() { local pid="`peco-ps $@`"; [ -n "$pid" ] && echo ">> kill \"$pid\"" && kill "$pid"; }

# man
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

# rip
RIP_PATTERN='$debug'

# load local bashrc
[ -f "$HOME/.local/etc/bashrc" ] && . "$HOME/.local/etc/bashrc"
