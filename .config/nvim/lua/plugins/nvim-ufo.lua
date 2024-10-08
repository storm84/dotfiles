return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zK', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })

    -- require('ufo').setup({
    --   provider_selector = function(bufnr, filetype, buftype)
    --     return { 'lsp', 'indent' }
    --   end
    -- })


    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true
    -- }
    -- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    -- for _, ls in ipairs(language_servers) do
    --   require('lspconfig')[ls].setup({
    --     capabilities = capabilities
    --     -- you can add other fields for setting up lsp server in this table
    --   })
    -- end
    -- require('ufo').setup()
  end
}
