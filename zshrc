# direnv
command -v direnv > /dev/null && eval "$(direnv hook zsh)"

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git
alias gti=git
if command -v diff-highlight > /dev/null; then
    export DIFF_HIGHLIGHT=$(command -v diff-highlight)
elif command -v brew > /dev/null && [[ -x "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ]]; then
    export DIFF_HIGHLIGHT="$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight"
else
    export DIFF_HIGHLIGHT="$(command -v cat)"
fi

# less
export PAGER=less
export LESS=-cRS

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
if command -v dircolors > /dev/null; then
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ghq
function peco-ghq() {
    ghq list -p | peco --query "$*"
}
function cdq() {
    local nwd="`peco-ghq $@`"
    [ -n "$nwd" ] && echo ">> cd \"$nwd\"" && cd "$nwd"
}

# powerline-shell
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}
function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}
if [[ "$TERM" != "linux" ]] && command -v powerline-shell > /dev/null; then
    install_powerline_precmd
fi

# vim
if [[ -n "${VIM_TERMINAL}" ]]; then
    function _vim_terminal_api_Tab() {
        if [[ "$#" = 0 ]]; then
            echo -ne "\x1b]51;[\"call\",\"Tapi_Tab_New\",[]]\x07"
        else
            local file_json="$(echo -n "${1}" | jq -R --slurp .)"
            echo -ne "\x1b]51;[\"call\",\"Tapi_Tab_Edit\",[${file_json}]]\x07"
        fi
    }
    alias :E=_vim_terminal_api_Tab
    alias :q=exit
    alias :tabnew=_vim_terminal_api_Tab
fi

# zsh
autoload -U compinit
compinit

# local zshrc
[[ -f "$HOME/.local/etc/zshrc" ]] && source "$HOME/.local/etc/zshrc"
