local mason_config = function()
  require("mason").setup()
end

local mason_lsp_config = function()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "csharp_ls",
      "gopls",
      "ts_ls"
    },
  })
end

local none_ls_config = function()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.csharpier,
      -- null_ls.builtins.diagnostics.eslint_d,
      require("none-ls.diagnostics.eslint_d"),
      null_ls.builtins.formatting.prettier,
    },
  })
end

local lsp_config = function()
  -- Setup language servers.
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
  })
  lspconfig.csharp_ls.setup({
    capabilities = capabilities,
  })
  lspconfig.gopls.setup({
    capabilities = capabilities,
  })
  lspconfig.ts_ls.setup({
    capabilities = capabilities,
  })
end

return {
  {
    "williamboman/mason.nvim",
    config = mason_config,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = mason_lsp_config,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = none_ls_config,
  },
  {
    "neovim/nvim-lspconfig",
    config = lsp_config,
  },
}
