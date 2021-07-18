# dotfiles

自分用の Unix ツールの設定。OS X 、 Ubuntu 、 CentOS を想定している。

## セットアップ

以下のコマンドでホームディレクトリ以下にシンボリックリンクがはられる。

```sh
$ git clone git@github.com:chick307/dotfiles.git ~/.local/src/github.com/chick307/dotfiles
$ cd ~/.local/src/github.com/chick307/dotfiles
$ ./setup.bash
$ . ~/.bash_profile
```

絶対パスでシンボリックリンクを作る。これ以外の場所に `git clone` しても問題ない。

`~/.local` 以下に `bin` `etc` `src` などのディレクトリを作る構成にしている。 `configure` を使ってインストールする場合は `./configure prefix=~/.local` としてもいい。 `ghq` の `root` は `~/.local/src` にしてある。

## bash

`~/.profile` `~/.bash_profile` `~/.bashrc` がこのレポジトリで管理される。ローカルのみの設定は `~/.local/etc/profile` `~/.local/etc/bashrc` に書くと読み込まれる。

## direnv

`~/.direnvrc` がこのレポジトリで管理される。

`.envrc` は `~/.gitignore` `~/.npmignore` に指定されいる。

## powerline-shell.py

`powerline-shell.py` にパスが通っているとそれを使う。渡される引数は `POWERLINE_SHELL_OPTS` 変数を通して変更できる。Poweline 用のフォントがインストールされているなら `~/.local/etc/bashrc` のなかで `POWERLINE_SHELL_OPTS` を編集し `--mode flat` 以外を渡すことができる。

## git

`~/.gitconfig` `~/.gitignore` がこのレポジトリで管理される。ローカルのみの設定は `~/.local/etc/gitconfig` と `~/.local/etc/gitignore` に書くと読み込まれる。

Git は 2.0 以上でないと `git pull` の時 `--ff-only` が自動で指定されず `brew update` などで問題になる場合がある。 `apt-get` や `yum` で入る `git` は古いので注意。

## vim

`~/.vimrc` `~/.vim/` がこのリポジトリで管理される。ローカルのみの設定は `~/.local/etc/vimrc` に書くと読み込まれる。

`direnv` 用に `vimrc_add` 関数が用意されている。 `.envrc` のなかで `vimrc_add "$PWD/.local.vimrc"` とするとそのディレクトリの `.local.vimrc` を読み込む。 それ以外の名前でも有効だが `~/.gitignore` や `~/.npmingnore` に指定してあるので、特に理由がなければ `.local.vimrc` という名前を使うのが簡単。

きちんと最新の Vim をインストールしないと問題が起こる。 `apt-get` や `yum` で入る `vim` は古いので注意。

## go

`GOPATH` が `~/.local/opt/go` に設定される。 `~/.local/opt/go/bin` にパスが通っているため、 `go get` でコマンドをインストールできる。

## npm

`~/.npmrc` `~/.npmignore` がこのレポジトリで管理される。ローカルのみの設定は `~/.local/etc/npmrc` に書くと読み込まれる。認証情報はそっちに移す。

勝手にパスの `~` を展開したり、シンボリックリンクを置き換えたりされて面倒くさい。

## その他

`~/.inputrc` `~/.dircolors` がこのレポジトリで管理される。
