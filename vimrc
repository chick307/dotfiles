" vim: ft=vim

" begin
set encoding=utf-8
scriptencoding utf-8
let g:mapleader = " "
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
augroup vimrc
  autocmd!
augroup END

" plugins
source $HOME/.vim/rc/plugins.vim

" filetypes
source $HOME/.vim/rc/filetypes.vim

" colorscheme
call dein#add('altercation/vim-colors-solarized')
autocmd vimrc ColorScheme solarized hi! LineNr ctermbg=NONE
autocmd vimrc ColorScheme solarized hi! SignColumn ctermbg=NONE
set background=dark
let g:solarized_termtrans = 1

" input method
autocmd vimrc InsertEnter,CmdwinEnter * set noimdisable
autocmd vimrc InsertLeave,CmdwinLeave * set imdisable

" mapping
nnoremap <up> <c-y>
nnoremap <down> <c-e>
nnoremap <left> <c-h>
nnoremap <right> <space>
nnoremap <pageup> <c-u>
nnoremap <pagedown> <c-d>
inoremap <left> <c-g>u<left>
inoremap <right> <c-g>u<right>
nnoremap k gk
nnoremap K gk
vnoremap K gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j
nnoremap 0 g0
nnoremap $ g$
vnoremap 0 g0
vnoremap $ g$
nnoremap g0 0
nnoremap g$ $
vnoremap g0 0
vnoremap g$ $
nnoremap gF gf
nnoremap <silent> gf :sp<cr>gf
nnoremap <c-[><c-[><c-[> :nohlsearch<cr>
nnoremap <silent> <leader># #``:echo '?'.@/<cr>
nnoremap <silent> <leader>* *``:echo '/'.@/<cr>

" netrw
nnoremap <silent> <leader>e :Explore<c-m>
nnoremap <silent> <leader>E :Texplore<c-m>

" paste
nnoremap <silent> <leader>p :set paste!<c-m>

" tab
command! -nargs=? -complete=file E tabnew <args>
nnoremap <silent> <c-h> gT
nnoremap <silent> <c-l> gt
autocmd vimrc FileType netrw nnoremap <buffer> <silent> <c-l> gt
nnoremap <leader>1 :tabfirst<cr>
nnoremap <leader>2 :tabfirst<cr>gt
tnoremap <c-w><leader>1 <c-w>:tabfirst<cr>
tnoremap <c-w><leader>2 <c-w>:tabfirst<cr>gt
nnoremap <silent> <c-t><c-h> :-tabmove<cr>
nnoremap <silent> <c-t><c-l> :+tabmove<cr>
tnoremap <silent> <c-h> <c-w>:tabprevious<cr>
tnoremap <silent> <c-l> <c-w>:tabnext<cr>

" terminal
autocmd vimrc TerminalWinOpen * setlocal ambiwidth=single nonumber signcolumn=no
nnoremap <silent> <leader>b :terminal ++close<cr>
nnoremap <silent> <leader>B :tab terminal ++close<cr>
tnoremap <silent> <c-w><leader>b <c-w>:terminal ++close<cr>
tnoremap <silent> <c-w><leader>B <c-w>:tab terminal ++close<cr>
source $HOME/.vim/rc/terminal-api.vim

" settings
set ambiwidth=double " encoding and unicode
set number ruler laststatus=2 " show line numbers and ruler
set showmatch
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set autoindent indentexpr=-1 " indent
set showtabline=2 " always show tabs
set nobackup noswapfile " no backup and swap file
set backupdir=/tmp
set clipboard=unnamed " yank to the clipboard.
set modeline modelines=2 " enable modelines
set backspace=indent,eol,start " allow backspace to delete indent
set list listchars=tab:\|\ ,trail:_
set nrformats="hex" " disable <C-a> and <C-x> when octal number
set hlsearch
set foldlevel=255
set wrap breakindent
set mouse=a
set wildmenu wildmode=list:longest,list:full
set scrolloff=3
set noerrorbells visualbell t_vb=
set nocursorline
set colorcolumn=121

" local vimrc
let s:local_vimrc = expand('~/.local/etc/vimrc')
if filereadable(s:local_vimrc)
  source `=s:local_vimrc`
endif

" extra vimrc
if exists("$EXTRA_VIMRC")
  for s:extra_vimrc in split($EXTRA_VIMRC, ':')
    exec "source ".s:extra_vimrc
  endfor
endif

" end
call dein#end()
syntax on
filetype plugin indent on
if dein#check_install()
  call dein#install()
endif
colorscheme solarized
