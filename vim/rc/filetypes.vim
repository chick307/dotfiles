" javascript
call dein#add('othree/yajs.vim')
call dein#add('othree/es.next.syntax.vim')
call dein#add('jason0x43/vim-js-indent')
let g:lsp_settings_filetype_javascript = 0
command! -nargs=* -complete=file Node terminal ++close node <args>

" json
autocmd vimrc FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let g:lsp_settings_filetype_json = ['efm-langserver']

" markdown
call dein#add('rcmdnk/vim-markdown')
call dein#add('dbridges/vim-markdown-runner')
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_initial_foldlevel=255
let g:vim_markdown_better_folding = 1
autocmd vimrc FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd vimrc FileType markdown setlocal colorcolumn=
autocmd vimrc FileType markdown nnoremap <buffer> <leader>r :MarkdownRunnerInsert<cr>
autocmd vimrc FileType markdown nnoremap <buffer> <leader>R :MarkdownRunner<cr>

" quickfix
autocmd vimrc FileType qf call s:on_quickfix_ft()
func! s:on_quickfix_ft() abort
  nnoremap <buffer> j j
  nnoremap <buffer> k k
  nmap <buffer> s <c-w><cr>
  nmap <buffer> t <c-w><cr><c-w>T
endfunc

" shell script
autocmd vimrc FileType sh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" typescript
call dein#add('leafgarland/typescript-vim')
let g:typescript_indent_disable = 1

" vim script
autocmd vimrc FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let g:vim_indent_cont=2

" yaml
autocmd vimrc FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
