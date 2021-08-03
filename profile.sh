function path-prepend() {
    local _name="${1}"
    local _value="${2}"
    local _path="$(printenv "${_name}")"
    if [[ "${_path}" = "" ]]; then
        export "${_name}=${_value}"
    elif [[ ":${_path}:" != *:"${_value}":* ]]; then
        export "${_name}=${_value}:${_path}"
    else
        export "${_name}=${_value}:${_path:#:${_value}:}"
    fi
}

function prefix-add() {
    path-prepend PATH "${1}/bin"
    path-prepend MANPATH "${1}/share/man"
}

prefix-add "/usr/local"
prefix-add "$HOME/.local"

# cargo
export CARGO_HOME="$HOME/.local/opt/cargo"
prefix-add "$CARGO_HOME"

# go
export GOPATH="$HOME/.local/opt/go"
prefix-add "$GOPATH"

# homebrew
prefix-add "$HOME/.local/opt/homebrew"

# node
prefix-add "$HOME/.local/opt/npm"

# python
export PYTHONUSERBASE="$HOME/.local/opt/pip"
prefix-add "$PYTHONUSERBASE"
