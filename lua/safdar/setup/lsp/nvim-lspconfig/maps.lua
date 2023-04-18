local utils = require("safdar.utils")

local set_buf_opt = utils.set_buf_opt
local set_map = utils.set_map

vim.StopAndStartLspServer = function()
	vim.cmd("LspStop")
	vim.cmd("LspStart")
end

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, buf_nr) -- will give client and bufnr
	local opts = utils.map_options:new()
	-- Enable completion triggered by <c-x><c-o>
	set_buf_opt(buf_nr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- set_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts:silent():noremap():buffer(bufnr))
	set_map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts:silent():noremap():buffer(buf_nr))
	set_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts:silent():noremap():buffer(buf_nr))
	set_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts:silent():noremap():buffer(buf_nr))
	-- set_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts:silent():noremap():buffer(bufnr))
	set_map(
		"n",
		"<space>wr",
		"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
		opts:silent():noremap():buffer(buf_nr)
	)
	set_map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts:silent():noremap():buffer(buf_nr))
	set_map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
	set_map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts:silent():noremap():buffer(buf_nr))
	-- set_map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts:silent():noremap():buffer(bufnr))
	set_map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts:silent():noremap():buffer(buf_nr))
	-- set_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts:silent():noremap():buffer(bufnr)) -- instead use the trouble
	-- set_map("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts:silent():noremap():buffer(bufnr))
	-- set_map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts:silent():noremap():buffer(bufnr))
	-- set_map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts:silent():noremap():buffer(bufnr))
	set_map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts:silent():noremap():buffer(buf_nr))
	set_map(
		"n",
		"<space>nf",
		"<cmd>lua vim.lsp.buf.format({async = true, timeout_ms = 2000 })<CR>",
		opts:silent():noremap():buffer(buf_nr)
	)
	set_map("n", "<leader>lR", ":lua vim.StopAndStartLspServer()<CR>", opts:silent():noremap():buffer(buf_nr))
	set_map("n", "<leader>lr", ":LspRestart<cr>", opts:silent():noremap():buffer(buf_nr))
	set_map("n", "<leader>li", ":LspInfo<cr>", opts:silent():noremap():buffer(buf_nr))
end

return M
