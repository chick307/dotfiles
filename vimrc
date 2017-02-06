" vim: ft=vim

set encoding=utf-8
scriptencoding utf-8
let g:mapleader = " "
if &compatible
 set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
filetype off
augroup vimrc
  autocmd!
augroup END

" surround
call dein#add('tpope/vim-surround')

" word
call dein#add('itchyny/vim-cursorword')

" syntastic
call dein#add('scrooloose/syntastic')
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_mode_map = { "mode": "passive" }
nnoremap <silent> <leader>l :SyntasticCheck<CR>
nnoremap <silent> <leader>L :SyntasticReset<CR>

" template
call dein#add('mattn/sonictemplate-vim')
let g:sonictemplate_vim_template_dir = ['~/.vim/template', '~/.local/etc/vim/template']

" markdown
call dein#add('rcmdnk/vim-markdown')
" see http://rcmdnk.github.io/blog/2014/10/30/computer-vim-markdown/
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_initial_foldlevel=255
let g:vim_markdown_better_folding = 1
autocmd vimrc FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd vimrc FileType markdown setlocal colorcolumn=

" javascript
call dein#add('othree/yajs.vim')
autocmd vimrc BufNewFile,BufRead gulpfile.js setlocal filetype=gulpfile.javascript

" typescript
call dein#add('leafgarland/typescript-vim')
call dein#add('jason0x43/vim-js-indent')
let g:syntastic_typescript_checkers = ['tslint']
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
call dein#add('mattn/emmet-vim')
let g:user_emmet_mode = 'inv'
let g:user_emmet_install_global = 0
autocmd vimrc FileType css,html,javascript,markdown,scss EmmetInstall
autocmd vimrc FileType css,html,javascript,markdown,scss
  \ imap <buffer> <C-z> <plug>(emmet-expand-abbr)

" vim script
autocmd vimrc FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let g:vim_indent_cont=2

" git
call dein#add('tpope/vim-fugitive')
call dein#add('junegunn/gv.vim')
let g:airline#extensions#branch#format = 1
nnoremap <silent> <leader>gb :Gblame<C-m>
nnoremap <silent> <leader>gv :GV<C-m>

" unite.vim
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/unite-outline')
nnoremap <silent> <leader>o :Unite outline<cr>
nnoremap <silent> <leader>t :Unite tab<C-m>

" ctrlp
call dein#add('kien/ctrlp.vim')
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|bower_components|node_modules)$'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-o>'],
  \ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
  \ }

nnoremap <leader><leader> :call <SID>start_ctrlp()<CR>

func! s:start_ctrlp()
  if exists('b:ctrlp_user_command')
    unlet b:ctrlp_user_command
  endif
  call system('git rev-parse --is-inside-git-dir')
  if v:shell_error == 0
    let b:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
    execute 'CtrlP'
  elseif v:shell_error == 128
    execute 'CtrlPCurFile'
  else
    execute 'CtrlP'
  endif
endfunc

" powerline
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
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
let g:airline_theme = 'solarized'
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
call dein#add('thinca/vim-quickrun')
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
nnoremap <leader>1 :tabfirst<cr>
nnoremap <silent> <C-t><C-h> :-tabmove<CR>
nnoremap <silent> <C-t><C-l> :+tabmove<CR>

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
inoremap " ""<C-g>U<Left>
inoremap "" ""
inoremap "<C-h> "<C-h>
inoremap ' ''<C-g>U<Left>
inoremap '' ''
inoremap '<C-h> '<C-h>
inoremap ` ``<C-g>U<Left>
inoremap `` ``
inoremap `<C-h> `<C-h>
inoremap ( ()<C-g>U<Left>
inoremap (; ();<C-g>U<Left><C-g>U<Left>
inoremap (;; (;;)
inoremap )( )(<C-g>U<Left>
inoremap () ()
inoremap (<C-h> (<C-h>
inoremap [ []<C-g>U<Left>
inoremap ][ ][<C-g>U<Left>
inoremap [] []
inoremap [<C-h> [<C-h>
inoremap [<C-m> [<C-m>]<C-o>O<C-g>u
inoremap [<C-m><C-i> [<C-m>]<C-o>O<C-g>u
inoremap [<C-m>; [<C-m>];<C-o>O<C-g>u
inoremap [;<C-m> [<C-m>];<C-o>O<C-g>u
inoremap { {}<C-g>U<Left>
inoremap {<Space> {<Space><Space>}<C-g>U<Left><C-g>U<Left>
inoremap }{ }{<C-g>U<Left>
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
call dein#add('lifepillar/vim-solarized8')
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

call dein#end()
syntax on
filetype plugin indent on
if dein#check_install()
  call dein#install()
endif

" solarized
if &term =~# "-256color$"
  set background=dark
  set t_Co=256
  let g:solarized_termcolors = 256
  let g:solarized_termtrans = 1
  colorscheme solarized8_dark
endif
