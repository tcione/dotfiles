
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

" TODO: Reintroduce when setup is more stable, rn is behaving weird
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
if isModuleAvailable('nvim-treesitter') then
  require'nvim-treesitter.configs'.setup({
    ensure_installed = {"ruby", "json", "bash", "javascript", "html", "css", "yaml", },
    highlight = { enable = true, },
    indent = { enable = true, },
    incremental_selection = { enable = true, },
  })
end

" TODO: Try to reintroduce cmp later, now it's just annoying me
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
" -- =======================================
" -- nvm-cmp
" -- =======================================
if isModuleAvailable('cmp') then
  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      },
      {
        { name = 'buffer' },
      }
    ),
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
      {
        { name = 'path' }
      },
      {
        { name = 'cmdline' }
      }
    )
  })
end


" Plug 'glepnir/lspsaga.nvim'
" nnoremap <leader>sf :Lspsaga lsp_finder<CR>
" nnoremap <leader>sa :Lspsaga code_action<CR>
" nnoremap <leader>sk :Lspsaga hover_doc<CR>
" nnoremap <leader>si :Lspsaga signature_help<CR>
" nnoremap <leader>sr :Lspsaga rename<CR>
" nnoremap <leader>sp :Lspsaga preview_definition<CR>
" nnoremap <leader>sd :Lspsaga show_line_diagnostics<CR>
" nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
" nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
" nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
" tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>
" -- =======================================
" -- LSP saga
" -- =======================================
if isModuleAvailable('lspsaga') then
  require('lspsaga').init_lsp_saga()
end
