local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")
local utils = require("safdar.setup.lsp.utils")
local on_attach = utils.on_attach
local capabilities = utils.capabilities

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local root_patterns = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".gitignore",
	".git",
}
nvim_lsp.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = util.root_pattern(root_patterns),
	handlers = {
		-- ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		-- 	-- Disable virtual_text
		-- 	virtual_text = false,
		-- }), -- this is handled in lsp-ui
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
