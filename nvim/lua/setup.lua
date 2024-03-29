function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

--
-- =======================================
-- lualine
-- =======================================
if isModuleAvailable('lualine') then
  require'lualine'.setup({
    options = { theme = 'jellybeans' }
  })
end

-- =======================================
-- telescope
-- =======================================
if isModuleAvailable('telescope') then
  local actions = require('telescope.actions')
  local telescope = require('telescope')
  telescope.load_extension('fzf')
  telescope.load_extension('emoji')
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    }
  })
end

-- =======================================
-- nvm-cmp
-- =======================================
if isModuleAvailable('cmp') then
  local cmp = require('cmp')

  cmp.setup({
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer' },
    }
  })
end

-- =======================================
-- Neovim LSP
-- =======================================
if isModuleAvailable('nvim-lsp-installer') then
  require("nvim-lsp-installer").setup({
    automatic_installation = true,
  })
end

if isModuleAvailable('lspconfig') then
  local nvim_lsp = require('lspconfig')

  local on_lsp_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  -- Enable LSP servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if isModuleAvailable('cmp_nvim_lsp') then
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  end

  nvim_lsp.solargraph.setup({
    cmd = { "solargraph", "stdio" },
    on_attach = on_lsp_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = capabilities,
  })
  nvim_lsp.flow.setup({
    on_attach = on_lsp_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = capabilities,
  })
  nvim_lsp.rust_analyzer.setup({
    on_attach = on_lsp_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = capabilities,
  })
  nvim_lsp.clangd.setup({
    on_attach = on_lsp_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = capabilities,
  })
  nvim_lsp.bashls.setup({
    on_attach = on_lsp_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = capabilities,
  })
end

-- =======================================
-- Neovim LSP Trouble
-- =======================================
if isModuleAvailable('trouble') then
  require("trouble").setup({
    fold_open = "v",
    fold_closed = ">",
    indent_lines = true,
    icons = false,
    signs = {
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_lsp_diagnostic_signs = false
  })
end

-- =======================================
-- LSP colors
-- =======================================
if isModuleAvailable('lsp-colors') then
  require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })
end

-- =======================================
-- Treesitter
-- =======================================
if isModuleAvailable('nvim-treesitter') then
  require'nvim-treesitter.configs'.setup({
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = { enable = true, additional_vim_regex_highlighting = false, },
    indent = { enable = false, },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "gtn",
        scope_incremental = "gtc",
        node_decremental = "gtm",
      },
    },
  })
end

-- =======================================
-- GitWorktree
-- =======================================
if isModuleAvailable('git-worktree') then
  local telescope = require("telescope")
  require("git-worktree").setup()
  telescope.load_extension("git_worktree")
  vim.api.nvim_set_keymap('n', '<leader>it', '<cmd> lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ia', '<cmd> lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>', { noremap = true, silent = true })
end


-- =======================================
-- Zen mode
-- =======================================
if isModuleAvailable('zen-mode') then
  require("zen-mode").setup({
    window = {
      backdrop = 1,
      width = 80,
      height = 1,
      options = {
        signcolumn = "no",
        number = false,
        colorcolumn = "",
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = true,
        showcmd = false,
        relativenumber = false,
        spell = true,
      },
      kitty = {
        enabled = false,
        font = "+4",
      },
    },
    on_open = function(win)
    end,
    on_close = function()
    end,
  })
end
