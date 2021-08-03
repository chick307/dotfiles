export LANG=ja_JP.UTF-8

# .profile.sh
[[ -f "$HOME/.profile.sh" ]] && . "$HOME/.profile.sh"

# local profile
[[ -f "$HOME/.local/etc/profile" ]] && . "$HOME/.local/etc/profile"

# vim: ft=bash
