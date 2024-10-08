local function prefix_with_group(group, desc)
	return group .. ": " .. desc
end

local workspace_group = "workspace"
local code_group = "code"
local find_group = "Find"
local git_group = "git"
local debug_group = "debug"

local telescope_builtin = require("telescope.builtin")

-- find
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = prefix_with_group(find_group, "[f]ile") })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = prefix_with_group(find_group, "[g]rep") })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = prefix_with_group(find_group, "[b]uffer") })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = prefix_with_group(find_group, "[h]elp tags") })
-- TODO setup git pickers and lsp pickers

-- git
vim.keymap.set(
	"n",
	"<leader>gl",
	telescope_builtin.git_commits,
	{ desc = prefix_with_group(git_group, "[c]ommit search") }
)
vim.keymap.set(
	"n",
	"<leader>ge",
	":Neotree toggle float git_status<CR>",
	{ desc = prefix_with_group(git_group, "[s]tatus window toggle") }
)

-- Neotree
vim.keymap.set("n", "<leader>e", ":Neotree toggle filesystem reveal left<CR>", { desc = "N[e]otree toggle" })

-- LSP Mappings
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "diagnostic open float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "diagnostic go to prev"})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "diagnostic go to next"})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "diagnostic location list"})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go to [D]eclaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "go to [d]efinition" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "go to [i]mplementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "go to [r]eferences" })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover"})
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf })
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type [D]efinition" })

		-- workspace
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
      { buffer = ev.buf, desc = prefix_with_group(workspace_group, "[a]dd workspace folder") })
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
      { buffer = ev.buf, desc = prefix_with_group(workspace_group, "[r]emove workspace folder") })
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = prefix_with_group(workspace_group, "[l]ist workspace folders") })

    -- code 
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = prefix_with_group(code_group, "[r]ename")})
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = prefix_with_group(code_group, "[c]ode actions") })
		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end, { buffer = ev.buf, desc = prefix_with_group(code_group, "code [f]ormatting") })

    require("which-key")
      .add({
        {"<leader>w", group = workspace_group },
        {"<leader>c", group = code_group },
      }, {buffer = ev.buf})
	end,
})

-- dap debug keymaps
local dap = require("dap")
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end)
vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end)
vim.keymap.set("n", "<F11>", function()
	dap.step_into()
end)
vim.keymap.set("n", "<F12>", function()
	dap.step_out()
end)
vim.keymap.set("n", "<Leader>db", function()
	dap.toggle_breakpoint()
end, {desc = prefix_with_group(debug_group, "[b]reakpoint toggle")})
-- vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
-- vim.keymap.set("n", "<Leader>cp", function()
-- 	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end)
vim.keymap.set("n", "<Leader>dr", function()
	dap.repl.open()
end, {desc = prefix_with_group(debug_group, "open [r]epl")})
vim.keymap.set("n", "<Leader>dl", function()
	dap.run_last()
end, {desc = prefix_with_group(debug_group, "run [l]ast")})
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
-- which-key mappings

local wk = require("which-key")
wk.add({
  { "<leader>f", group = find_group },
  { "<leader>g", group = git_group },
  { "<leader>w", group = workspace_group },
  { "<leader>c", group = code_group },
  { "<leader>d", group = debug_group },
})
