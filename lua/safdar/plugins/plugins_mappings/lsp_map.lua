local utils = require("safdar.core.utils")
local vim = vim
local command = vim.api.nvim_command

local buf_set_option = utils.buf_set_opt
local buf_set_keymap = utils.buf_set_map

local map = utils.set_map
local opts = { noremap = true, silent = true }

vim.StopAndStartLspServer = function()
	command(":LspStop<CR>")
	command(":LspStart<CR>")
end

map("n", "<leader>nf", "", { noremap = true, silent = true })

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, bufnr) -- will give client and bufnr
	-- Enable completion triggered by <c-x><c-o>
	buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- buf_set_keymap(bufnr,"n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- buf_set_keymap(
	--     bufnr,
	--     "n",
	--     "gd",
	--     "<cmd>lua vim.lsp.buf.definition()<CR>",
	--     opts
	-- )
	buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- buf_set_keymap(bufnr,"n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- buf_set_keymap(bufnr,"n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- buf_set_keymap(
	--     bufnr,
	--     "n",
	--     "<space>ca",
	--     "<cmd>lua vim.lsp.buf.code_action()<CR>",
	--     opts
	-- )
	-- buf_set_keymap(bufnr,"n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- instead use the trouble
	-- buf_set_keymap(bufnr,"n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	-- buf_set_keymap(bufnr,"n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- buf_set_keymap(bufnr,"n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap(bufnr, "n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap(bufnr, "n", "<space>nf", "<cmd>lua vim.lsp.buf.format({async = true, timeout_ms = 2000 })<CR>", opts)
	buf_set_keymap(bufnr, "n", "<leader>lR", ":lua vim.StopAndStartLspServer()<CR>", opts)
	buf_set_keymap(bufnr, "n", "<leader>lr", ":LspRestart<cr>", opts)
	buf_set_keymap(bufnr, "n", "<leader>li", ":LspInfo<cr>", opts)
end
return M
