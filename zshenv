# language
export LANG=ja_JP.UTF-8

# path
function path_add() {
    if [[ "$PATH" = "" ]]; then
        export PATH="$1"
    elif echo ":$PATH:" | grep -v ":$1:" > /dev/null 2>&1; then
        export PATH="$1:$PATH"
    fi
}
if command -v brew > /dev/null; then
    path_add "$(brew --prefix)/bin"
    path_add "$(brew --prefix)/sbin"
fi
path_add "$HOME/.local/opt/go/bin"
path_add "$HOME/.local/opt/npm/bin"
path_add "$HOME/.local/opt/pip/bin"
path_add "$HOME/.local/bin"
export MANPATH="$HOME/.local/share/man:$MANPATH"

# go
export GOPATH="$HOME/.local/opt/go"

# python
export PYTHONUSERBASE="$HOME/.local/opt/pip"

# vim
export EDITOR=vim

# local zshenv
[[ -f "$HOME/.local/etc/zshenv" ]] && source "$HOME/.local/etc/zshenv"
