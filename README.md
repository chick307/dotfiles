# dotfiles

自分用の Unix ツールの設定。OS X 、 Ubuntu 、 CentOS を想定している。

## セットアップ

以下のコマンドでホームディレクトリ以下にシンボリックリンクがはられる。

```sh
$ git clone git@github.com:chick307/dotfiles.git ~/.local/src/github.com/chick307/dotfiles
$ cd ~/.local/src/github.com/chick307/dotfiles
$ bash ./setup.bash
```

絶対パスでシンボリックリンクを作る。これ以外の場所に `git clone` しても問題ない。

`~/.local` 以下に `bin` `etc` `src` などのディレクトリを作る構成にしている。 `configure` を使ってインストールする場合は `./configure prefix=~/.local` としてもいい。

## bash

`~/.profile` `~/.bash_profile` `~/.bashrc` がこのレポジトリで管理される。ローカルのみの設定は `~/.local/etc/profile` `~/.local/etc/bashrc` に書くと読み込まれる。

## direnv

`~/.direnvrc` がこのレポジトリで管理される。

`.envrc` は `~/.gitignore` `~/.npmignore` に指定されている。

## powerline-shell

`powerline-shell` コマンドが存在すれば、それを使う。

## git

`~/.gitconfig` `~/.gitignore` を管理する。ローカルのみの設定は `~/.local/etc/gitconfig` に書くと読み込まれる。

Git は 2.0 以上でないと `git pull` の時 `--ff-only` が自動で指定されず `brew update` などで問題になる場合がある。 `apt-get` や `yum` で入る `git` は古いので注意。

## vim

`~/.vimrc` `~/.vim/` がこのリポジトリで管理される。ローカルのみの設定は `~/.local/etc/vimrc` に書くと読み込まれる。

`direnv` 用に `vimrc_add` 関数が用意されている。 `.envrc` のなかで `vimrc_add "$PWD/.local.vimrc"` とするとそのディレクトリの `.local.vimrc` を読み込む。 それ以外の名前でも有効だが `~/.gitignore` や `~/.npmingnore` に指定してあるので、特に理由がなければ `.local.vimrc` という名前を使うのが簡単。

きちんと最新の Vim をインストールしないと問題が起こる。 `apt-get` や `yum` で入る `vim` は古いので注意。

powerline のフォントを使っている場合 `~/.local/etc/vimrc` に、

```vim
let g:airline_left_sep = "\uE0B0"
let g:airline_left_alt_sep = "\uE0B1"
```

と書いておく。

## go

`GOPATH` が `~/.local/opt/go` に設定される。 `~/.local/opt/go/bin` にパスが通っているため、 `go get` でコマンドをインストールできる。

## npm

`~/.npmrc` `~/.npmignore` がこのレポジトリで管理される。

`prefix` は `~/.local/opt/npm` に設定され、 `bin` にパスが通される。 `npm i -g` でインストールされたものはそこに置かれる。

`npm login` をすると勝手にパスの `~` を展開されるので直す。 `//registry.npmjs.org/:_authToken=` は `~/.local/opt/npm/etc/npmrc` に書き写しておく。

## pip

`PYTHONUSERBASE` は `~/.local/opt/pip` に設定され、 `bin` にパスが通される。 `pip install --user` でインストールされたものはそこに置かれる。

## ghq

`ghq.root` は `~/.local/src` に設定される。

`ghq` で管理されるリポジトリを `peco` で選び `cd` する `cdq` 関数が定義される。

## zsh

`~/.zshenv` `~/.zshrc` `~/.zprofile` を管理する。ローカルの設定は `~/.local/etc/zshenv` `~/.local/etc/zshrc` `~/.local/etc/zprofile`

## その他

`~/.inputrc` `~/.dircolors` がこのレポジトリで管理される。
