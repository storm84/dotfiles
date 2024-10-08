return {
  -- The plugin location on GitHub
  "vimwiki/vimwiki",
  -- The event that triggers the plugin
  event = "BufEnter *.md",
  -- The keys that trigger the plugin
  keys = { "<leader>ww", "<leader>wt" },
  -- The configuration for the plugin
  init = function()
    vim.g.vimwiki_list = {
      {
        -- Here will be the path for your wiki
        path = "~/vimwiki/",
        -- The syntax for the wiki
        syntax = "markdown",
        ext = "md",
      },
    }
    
    -- vim.g.vimwiki_ext2syntax = { }
    vim.g.vimwiki_global_ext = 0
    -- quit vimwiki by closing all open buffers
    vim.keymap.set("n", "<leader>wq", [[:bufdo if expand('%') =~ 'vimwiki/' | bd | endif<CR>]],
      { desc = "vimwiki: [q]uit", noremap = true, silent = true })


    -- Function to link Vimwiki headers to Markdown syntax highlight groups (used by LSP)
    local function set_vimwiki_header_colors()
      -- Link Vimwiki header highlighting to Markdown header highlight groups used by LSP
      vim.cmd("highlight link VimwikiHeader1 markdownH1") -- Map Vimwiki level 1 header to markdown H1
      vim.cmd("highlight link VimwikiHeader2 markdownH2") -- Map Vimwiki level 2 header to markdown H2
      vim.cmd("highlight link VimwikiHeader3 markdownH3") -- Map Vimwiki level 3 header to markdown H3
      vim.cmd("highlight link VimwikiHeader4 markdownH4") -- Map Vimwiki level 4 header to markdown H4
      vim.cmd("highlight link VimwikiHeader5 markdownH5") -- Map Vimwiki level 5 header to markdown H5
      vim.cmd("highlight link VimwikiHeader6 markdownH6") -- Map Vimwiki level 6 header to markdown H6

      -- Match headers with the respective highlight groups
      vim.cmd("syntax match VimwikiHeader1 '^# .*$'")
      vim.cmd("syntax match VimwikiHeader2 '^## .*$'")
      vim.cmd("syntax match VimwikiHeader3 '^### .*$'")
      vim.cmd("syntax match VimwikiHeader4 '^#### .*$'")
      vim.cmd("syntax match VimwikiHeader5 '^##### .*$'")
      vim.cmd("syntax match VimwikiHeader6 '^###### .*$'")
    end

    -- Apply the header colors only for Vimwiki file types
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vimwiki",
      callback = set_vimwiki_header_colors,
    })
  end,
}
