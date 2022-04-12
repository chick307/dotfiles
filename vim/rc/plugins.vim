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
let g:asyncomplete_min_chars = 1

" auto-pairs
call dein#add('jiangmiao/auto-pairs')

" ctrlp
call dein#add('kien/ctrlp.vim')
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|bower_components|node_modules)$'
let g:ctrlp_prompt_mappings = {}
let g:ctrlp_prompt_mappings['AcceptSelection("e")'] = ['<c-o>']
let g:ctrlp_prompt_mappings['AcceptSelection("t")'] = ['<cr>', '<c-t>']
nnoremap <leader><leader> :call <sid>start_ctrlp()<cr>
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

" cursorword
call dein#add('itchyny/vim-cursorword')

" dispatch
call dein#add('tpope/vim-dispatch')

" emmet
call dein#add('mattn/emmet-vim')
let g:user_emmet_mode = 'inv'

" git
call dein#add('tpope/vim-fugitive')
call dein#add('junegunn/gv.vim')
let g:airline#extensions#branch#format = 1
nnoremap <silent> <leader>gb :Gblame<C-m>
nnoremap <silent> <leader>gv :GV<C-m>
command! -nargs=0 Tig tab terminal ++close tig

" highlightedyank
call dein#add('machakann/vim-highlightedyank')
let g:highlightedyank_highlight_duration = 100

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
nnoremap gd :topleft :LspDefinition<cr>
nmap gD <plug>(lsp-definition)
nnoremap gi :topleft :LspImplementation<cr>
nmap gI <plug>(lsp-implementation)
nmap gr <plug>(lsp-references)
nnoremap gt :topleft :LspTypeDefinition<cr>
nmap gT <plug>(lsp-type-definition)
nmap ]] <plug>(lsp-next-diagnostic)
nmap [[ <plug>(lsp-previous-diagnostic)
nmap <leader>h <plug>(lsp-hover)
autocmd vimrc User lsp_buffer_enabled setlocal signcolumn=yes omnifunc=lsp#complete
let g:airline#extensions#lsp#enabled = 1
let g:airline#extensions#lsp#show_line_numbers = 0
let g:airline#extensions#lsp#error_symbol = 'E '
let g:airline#extensions#lsp#warning_symbol = 'W '
let g:lsp_settings = {}
let g:lsp_settings['efm-langserver'] = { 'disabled': v:false }

" neosnippet
call dein#add('Shougo/neosnippet')
call dein#add('prabirshrestha/asyncomplete-neosnippet.vim',
  \ { 'depends': ['Shougo/neosnippet', 'prabirshrestha/asyncomplete.vim'] })
autocmd vimrc User asyncomplete_setup
  \ call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
  \ 'name': 'neosnippet', 'allowlist': ['*'], 'completor': function('asyncomplete#sources#neosnippet#completor') }))
let g:neosnippet#snippets_directory='~/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
imap <c-k> <plug>(neosnippet_expand_or_jump)
smap <c-k> <plug>(neosnippet_expand_or_jump)
smap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"
xmap <c-k> <plug>(neosnippet_expand_target)

" quickrun
call dein#add('thinca/vim-quickrun')
let g:quickrun_config = {}
let g:quickrun_config['_'] = { 'runner' : 'vimproc', 'runner/vimproc/updatetime' : 60 }
nmap <leader>r <plug>(quickrun)

" repeat
call dein#add('tpope/vim-repeat')

" sonictemplate
call dein#add('mattn/sonictemplate-vim')
let g:sonictemplate_vim_template_dir = ['~/.vim/template', '~/.local/etc/vim/template']
autocmd vimrc FileType stpl setlocal noexpandtab

" surround
call dein#add('tpope/vim-surround', { 'depends': ['tpope/vim-repeat'] })

" test
call dein#add('vim-test/vim-test')
let g:test#strategy = 'dispatch'
nnoremap <silent> <leader>Ta :TestSuite -strategy=vimterminal<cr>
nnoremap <silent> <leader>ta :TestSuite<cr>
nnoremap <silent> <leader>Tf :TestFile -strategy=vimterminal<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>Tt :TestNearest -strategy=vimterminal<cr>
nnoremap <silent> <leader>tt :TestNearest<cr>

" textobj-comment
call dein#add('glts/vim-textobj-comment', { 'depends': ['kana/vim-textobj-user'] })

" textobj-user
call dein#add('kana/vim-textobj-user')
