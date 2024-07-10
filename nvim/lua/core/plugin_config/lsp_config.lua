-- Because 'mason', 'mason-lspconfig', and 'lspconfig' work together,
-- I keep all of them contained in one config file here rather
-- than separate like the rest of the plugins
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "texlab",
    "jdtls",
    "lua_ls",
    "rust_analyzer",
    "emmet_ls",
    "dockerls",
    "omnisharp"
  }
})

-- Allows the user to get more info on items in the code
-- via keybinds as specified
local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

-- For autocompletion and snippets
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
}

require("lspconfig").texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require("lspconfig").jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require("lspconfig").emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"html", "css", "javascript"},
}

require("lspconfig").dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require("lspconfig").omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
