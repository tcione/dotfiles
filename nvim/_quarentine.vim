
" Syntax mapping

" LSP

" =========================================
" Quarentine
" =========================================
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
command! -nargs=* Wrap set wrap linebreak nolist

Plug 'nvim-lua/lsp_extensions.nvim'
nnoremap <Leader>T :lua require'lsp_extensions'.inlay_hints()<cr>
nnoremap <Leader>t :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }<cr>
