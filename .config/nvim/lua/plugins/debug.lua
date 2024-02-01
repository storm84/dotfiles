local dap_config = function()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup()

  -- configure dap servers

  -- configure golang (delve )
  require("dap-go").setup()

  -- configure .net (netcoredbg)
  dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/bin/netcoredbg',
    args = { '--interpreter=vscode' }
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }



  -- configure dapui to automatically open and close windows based on nvim-dap events
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- keymaps
  vim.keymap.set('n', '<F5>', function() dap.continue() end)
  vim.keymap.set('n', '<F10>', function() dap.step_over() end)
  vim.keymap.set('n', '<F11>', function() dap.step_into() end)
  vim.keymap.set('n', '<F12>', function() dap.step_out() end)
  vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
  -- vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
  vim.keymap.set('n', '<Leader>lp',
    function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
  vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
  -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  --   require('dap.ui.widgets').hover()
  -- end)
  -- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  --   require('dap.ui.widgets').preview()
  -- end)
  -- vim.keymap.set('n', '<Leader>df', function()
  --   local widgets = require('dap.ui.widgets')
  --   widgets.centered_float(widgets.frames)
  -- end)
  -- vim.keymap.set('n', '<Leader>ds', function()
  --   local widgets = require('dap.ui.widgets')
  --   widgets.centered_float(widgets.scopes)
  -- end)
end

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = dap_config
  },
  {
    "leoluz/nvim-dap-go",
  }
}
