_which() { which $@ 2> /dev/null; }

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

# direnv
[ -x "$(_which direnv)" ] && eval "$(direnv hook bash)"

# powerline
if [ -x "$(_which powerline-shell.py)" -o -x "$HOME/.local/bin/powerline-shell.py" ]; then
    export PROMPT_COMMAND="_exit_code=\$?; $PROMPT_COMMAND; update-ps1-powerline \$_exit_code"
    export POWERLINE_SHELL_OPTS="--shell bash --mode flat --cwd-max-depth 4"
    update-ps1-powerline() {
        export PS1="$(powerline-shell.py $POWERLINE_SHELL_OPTS $1 2> /dev/null)"
    }
fi

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

# bash completion
[ -x "$(_which brew)" ] && [ -f "$(brew --prefix)/etc/bash_completion" ] && \
    . "$(brew --prefix)/etc/bash_completion"

# history
bind -x '"\C-r": readline-peco-history'
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

# rip
RIP_PATTERN='$debug'

# load local bashrc
[ -f "$HOME/.local/etc/bashrc" ] && . "$HOME/.local/etc/bashrc"
