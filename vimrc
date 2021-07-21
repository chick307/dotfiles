" vim: ft=vim

set encoding=utf-8
scriptencoding utf-8
let g:mapleader = " "
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
augroup vimrc
  autocmd!
augroup END

" airline
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
let g:airline_powerline_fonts = 0
let g:airline_symbols = {}
let g:airline_symbols_ascii = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme = 'solarized'
let g:airline_mode_map = {}
let g:airline_section_z = 'L%l/%L:%v'
let g:airline#extensions#branch#format = 2

" asynccomplete
call dein#add('prabirshrestha/asyncomplete.vim')

" auto-pairs
call dein#add('jiangmiao/auto-pairs')

" dispatch
call dein#add('tpope/vim-dispatch')

" surround
call dein#add('tpope/vim-surround')

" word
call dein#add('itchyny/vim-cursorword')

" sonictemplate
call dein#add('mattn/sonictemplate-vim')
let g:sonictemplate_vim_template_dir = ['~/.vim/template', '~/.local/etc/vim/template']
let g:sonictemplate_postfix_key = '<c-k>'

" test
call dein#add('vim-test/vim-test')
let g:test#strategy = 'dispatch'
nnoremap <silent> <leader>ta :TestSuite<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>tt :TestNearest<cr>

" lsp
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_code_action_signs_enabled = 0
nmap <leader>a <plug>(lsp-code-action)
nmap <leader>d <plug>(lsp-document-diagnostics)
nmap 1f <plug>(lsp-document-format)
vmap 1f <plug>(lsp-document-format)
nmap 1r <plug>(lsp-rename)
nmap gd :sp<cr><plug>(lsp-definition)
nmap gi :sp<cr><plug>(lsp-implementation)
nmap gr :sp<cr><plug>(lsp-references)
nmap gt :sp<cr><plug>(lsp-type-definition)
nmap ]] <plug>(lsp-next-diagnostic)
nmap [[ <plug>(lsp-previous-diagnostic)
nmap <leader>h <plug>(lsp-hover)
autocmd vimrc User lsp_buffer_enabled setlocal signcolumn=yes omnifunc=lsp#complete
let g:airline#extensions#lsp#enabled = 1
let g:airline#extensions#lsp#show_line_numbers = 0
let g:airline#extensions#lsp#error_symbol = 'E '
let g:airline#extensions#lsp#warning_symbol = 'W '

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
command! -nargs=* -complete=file Node terminal ++close node <args>

" typescript
call dein#add('leafgarland/typescript-vim')
call dein#add('jason0x43/vim-js-indent')
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

" vim script
autocmd vimrc FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let g:vim_indent_cont=2

" git
call dein#add('tpope/vim-fugitive')
call dein#add('junegunn/gv.vim')
let g:airline#extensions#branch#format = 1
nnoremap <silent> <leader>gb :Gblame<C-m>
nnoremap <silent> <leader>gv :GV<C-m>
command! -nargs=0 Tig tab terminal ++close tig

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
nnoremap <silent> <leader>b :call <SID>open_shell()<C-m>
func! s:open_shell()
  terminal ++close
endfunc

" tab
command! -nargs=? -complete=file E tabnew <args>
nnoremap <silent> <C-h> gT
nnoremap <silent> <C-l> gt
autocmd vimrc FileType netrw nnoremap <buffer> <silent> <C-l> gt
nnoremap <leader>1 :tabfirst<cr>
nnoremap <silent> <C-t><C-h> :-tabmove<CR>
nnoremap <silent> <C-t><C-l> :+tabmove<CR>
tnoremap <silent> <C-h> <C-w>:tabprevious<CR>
tnoremap <silent> <C-l> <C-w>:tabnext<CR>

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

" disable IME in normal mode
autocmd vimrc InsertEnter,CmdwinEnter * set noimdisable
autocmd vimrc InsertLeave,CmdwinLeave * set imdisable

" mapping
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
nnoremap <Left> <C-h>
nnoremap <Right> <Space>
nnoremap <PageUp> <C-u>
nnoremap <PageDown> <C-d>
inoremap <silent> jj <C-[>
inoremap <Left> <C-g>U<Left>
inoremap <Right> <C-g>U<Right>
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
set background=dark
let g:solarized_termtrans = 1
autocmd vimrc ColorScheme solarized8 hi! Comment ctermfg=244 ctermbg=NONE cterm=NONE
autocmd vimrc ColorScheme solarized8 hi! def link gitcommitComment Comment
colorscheme solarized8
