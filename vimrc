" vim: ft=vim

set encoding=utf-8
scriptencoding utf-8
let g:mapleader = " "
if has('vim_starting')
   if &compatible
     set nocompatible
   endif
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
filetype off
augroup vimrc
  autocmd!
augroup END

" vimproc
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \   'windows' : 'tools\\update-dll-mingw',
  \   'cygwin' : 'make -f make_cygwin.mak',
  \   'mac' : 'make -f make_mac.mak',
  \   'linux' : 'make',
  \   'unix' : 'gmake',
  \   },
  \ }

" surround
NeoBundle 'tpope/vim-surround'

" word
NeoBundle 'itchyny/vim-cursorword'

" markdown
NeoBundle 'rcmdnk/vim-markdown'
" see http://rcmdnk.github.io/blog/2014/10/30/computer-vim-markdown/
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_initial_foldlevel=255
let g:vim_markdown_better_folding = 1
autocmd vimrc FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd vimrc FileType markdown setlocal colorcolumn=

" javascript
NeoBundle 'othree/yajs.vim'

" typescript
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'jason0x43/vim-js-indent'
let g:typescript_indent_disable = 1

" json
autocmd vimrc FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd vimrc FileType json nnoremap <buffer> <leader>f :call <sid>json_format()<cr>
autocmd vimrc BufNewFile,BufRead .babelrc setlocal filetype=json

func! s:json_format()
  if executable('jq')
    execute '%!jq .'
  else
    throw '"jq" command is required'
  endif
endfunc

" yaml
autocmd vimrc FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" shell script
autocmd vimrc FileType sh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" emmet
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_mode = 'inv'
let g:user_emmet_install_global = 0
autocmd vimrc FileType html,css,markdown,javascript EmmetInstall
autocmd vimrc FileType html,css,markdown,javascript
  \ imap <buffer> <C-z> <plug>(emmet-expand-abbr)

" vim script
autocmd vimrc FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let g:vim_indent_cont=2

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'junegunn/gv.vim'
let g:airline#extensions#branch#format = 1
nnoremap <silent> <leader>gb :Gblame<C-m>
nnoremap <silent> <leader>gv :GV<C-m>

" unite.vim
NeoBundle 'Shougo/unite.vim'
nnoremap <silent> <leader>t :Unite tab<C-m>

" ctrlp
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|bower_components|node_modules)$'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-o>'],
  \ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
  \ }

" powerline
NeoBundle 'bling/vim-airline'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.paste = 'P'
let g:airline_symbols.whitespace = 'W'
let g:airline_symbols.branch = 'B'
let g:airline_symbols.readonly = 'R'
let g:airline_symbols.linenr = 'L'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" quickrun
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
  \ '_' : {
  \   'runner' : 'vimproc',
  \   'runner/vimproc/updatetime' : 60
  \   }
  \ }

" paste mode
nnoremap <silent> <leader>p :set paste!<C-m>

" explorer
nnoremap <silent> <leader>e :Explore<C-m>
nnoremap <silent> <leader>E :Texplore<C-m>

" shell
nnoremap <silent> <leader>b :shell<C-m>

" tab
command! -nargs=? -complete=file E tabnew <args>
nnoremap <silent> <C-h> gT
nnoremap <silent> <C-l> gt

" settings
set encoding=utf-8 ambiwidth=double " encoding and unicode
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

" disable IME in normal mode
autocmd vimrc InsertEnter,CmdwinEnter * set noimdisable
autocmd vimrc InsertLeave,CmdwinLeave * set imdisable

" completion
inoremap " ""<Left>
inoremap "" ""
inoremap "<C-h> "<C-h>
inoremap ' ''<Left>
inoremap '' ''
inoremap '<C-h> '<C-h>
inoremap ` ``<Left>
inoremap `` ``
inoremap `<C-h> `<C-h>
inoremap ( ()<Left>
inoremap (; ();<Left><Left>
inoremap (;; (;;)
inoremap )( )(<Left>
inoremap () ()
inoremap (<C-h> (<C-h>
inoremap [ []<Left>
inoremap ][ ][<Left>
inoremap [] []
inoremap [<C-h> [<C-h>
inoremap [<C-m> [<C-m>]<C-o>O<C-g>u
inoremap [<C-m><C-i> [<C-m>]<C-o>O<C-g>u
inoremap [<C-m>; [<C-m>];<C-o>O<C-g>u
inoremap [;<C-m> [<C-m>];<C-o>O<C-g>u
inoremap { {}<Left>
inoremap }{ }{<Left>
inoremap {} {}
inoremap {<C-h> {<C-h>
inoremap {<C-m> {<C-m>}<C-o>O<C-g>u
inoremap {<C-m><C-i> {<C-m>}<C-o>O<C-g>u
inoremap {<C-m>; {<C-m>};<C-o>O<C-g>u
inoremap {;<C-m> {<C-m>};<C-o>O<C-g>u

" mapping
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
nnoremap <Left> <C-h>
nnoremap <Right> <Space>
nnoremap <PageUp> <C-u>
nnoremap <PageDown> <C-d>
inoremap <silent> jj <C-[>
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
nnoremap <C-[><C-[><C-[> :nohlsearch<C-m>

" colorscheme
NeoBundle 'altercation/vim-colors-solarized'
if &term =~# "-256color$"
  set runtimepath+=$HOME/.vim/bundle/vim-colors-solarized
  set background=dark
  set t_Co=256
  let g:solarized_termcolors = 256
  let g:solarized_termtrans = 1
  colorscheme solarized
endif
execute 'set colorcolumn=' . join(range(81, 1000), ',')

let s:local_vimrc = expand('~/.local/etc/vimrc')
if filereadable(s:local_vimrc)
  source `=s:local_vimrc`
endif

if exists("$EXTRA_VIMRC")
  for s:extra_vimrc in split($EXTRA_VIMRC, ':')
    exec "source ".s:extra_vimrc
  endfor
endif

call neobundle#end()
syntax on
filetype plugin indent on
NeoBundleCheck
