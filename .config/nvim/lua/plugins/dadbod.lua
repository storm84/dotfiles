local function urlencode(str)
  return str:gsub("([^%w _%%%-%.~])", function(char)
    return string.format("%%%02X", string.byte(char))
  end):gsub(" ", "+")
end

return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod',                     lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1

    -- local eb_user = urlencode('marcus.storm@earlybird.se')
    -- local local_user = 'postgres:abc123';
    local eb_user = urlencode(os.getenv('PG_EB_USER'))
    local local_user = os.getenv('PG_LOCAL_USER');
    vim.g.dbs = {
      --munin
      { name = 'munin      [local]',   url = 'postgres://' .. local_user .. '@localhost:5432/munin-api' },
      { name = 'munin      [dev]',   url = 'postgres://' .. eb_user .. '@localhost:2101/munin-api' },
      { name = 'munin      [test]',   url = 'postgres://' .. eb_user .. '@localhost:2102/munin-api' },
      { name = 'munin      [stage]',   url = 'postgres://' .. eb_user .. '@localhost:2103/munin-api' },
      { name = 'munin      [prod]',   url = 'postgres://' .. eb_user .. '@localhost:2104/munin-api' },

      -- niffler
      { name = 'niffler    [local]', url = 'postgres://' .. local_user .. '@localhost:5432/niffler' },
      { name = 'niffler    [dev]', url = 'postgres://' .. eb_user .. '@localhost:2001/niffler' },
      { name = 'niffler    [test]', url = 'postgres://' .. eb_user .. '@localhost:2002/niffler' },
      { name = 'niffler    [stage]', url = 'postgres://' .. eb_user .. '@localhost:2003/niffler' },
      { name = 'niffler    [prod]', url = 'postgres://' .. eb_user .. '@localhost:2004/niffler' },
      { name = 'niffler    [prod-r]', url = 'postgres://' .. eb_user .. '@localhost:2005/niffler' },


      -- replica only
      { name = 'deadletter [prod-r]', url = 'postgres://' .. eb_user .. '@localhost:2005/deadletter' },
      -- {
      --   name = 'production',
      --   url = function()
      --     return vim.fn.system('get-prod-url')
      --   end
      -- },
    }
  end,
}
