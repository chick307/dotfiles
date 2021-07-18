_which() { which $@ 2> /dev/null; }

# go
export GOPATH="$HOME/.local/opt/go"

# python
export PYTHONUSERBASE=$HOME/.local/opt/pip

# homebrew
homebrew_prefix="/usr/local"
if [ -x "$(_which apt-get || _which yum)" ]; then
    homebrew_prefix="$HOME/.linuxbrew"
fi
export PATH="$homebrew_prefix/bin:$homebrew_prefix/sbin:$PATH"
export MANPATH="$homebrew_prefix/share/man:$MANPATH"

# path
export PATH="$HOME/.local/opt/go/bin:$PATH"
export PATH="$HOME/.local/opt/npm/bin:$PATH"
export PATH="$HOME/.local/opt/pip/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# manpath
export MANPATH="$HOME/.local/share/man:$MANPATH"

[ -f "$HOME/.local/etc/profile" ] && . "$HOME/.local/etc/profile"
