local utils = require("safdar.utils")

local set_buf_opt = utils.set_buf_opt
local set_buf_map = utils.set_buf_map
local opts = { noremap = true, silent = true }

vim.StopAndStartLspServer = function()
	vim.cmd("LspStop")
	vim.cmd("LspStart")
end

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, bufnr) -- will give client and bufnr
	-- Enable completion triggered by <c-x><c-o>
	set_buf_opt(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- set_buf_map(bufnr,"n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	set_buf_map( bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	set_buf_map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	set_buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- set_buf_map(bufnr,"n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	set_buf_map(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	set_buf_map(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	set_buf_map(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	set_buf_map(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- set_buf_map(bufnr,"n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- set_buf_map(
	--     bufnr,
	--     "n",
	--     "<space>ca",
	--     "<cmd>lua vim.lsp.buf.code_action()<CR>",
	--     opts
	-- )
	-- set_buf_map(bufnr,"n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- instead use the trouble
	-- set_buf_map(bufnr,"n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	-- set_buf_map(bufnr,"n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- set_buf_map(bufnr,"n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	set_buf_map(bufnr, "n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	set_buf_map(bufnr, "n", "<space>nf", "<cmd>lua vim.lsp.buf.format({async = true, timeout_ms = 2000 })<CR>", opts)
	set_buf_map(bufnr, "n", "<leader>lR", ":lua vim.StopAndStartLspServer()<CR>", opts)
	set_buf_map(bufnr, "n", "<leader>lr", ":LspRestart<cr>", opts)
	set_buf_map(bufnr, "n", "<leader>li", ":LspInfo<cr>", opts)
end

return M
