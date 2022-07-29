--=======================================================
--                      lsp general
--=======================================================
local vim = vim
local nvim_lsp = require("lsp.lsp_util").nvim_lsp
local on_attach = require("core.plugins_mappings.lsp_map").on_attach
local capabilities = require("lsp.lsp_util").capabilities

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- enable lang_servers with same configs alll in one
local servers = {
	--love
	"html",
	"cssls",
	"tailwindcss",
	"tsserver",

	-- BUG:
	-- "stylelint_lsp",
	-- "emmet_ls",

	-- crush
	-- "clangd",
	"sumneko_lua",
	"vimls",

	-- fun
	"rust_analyzer",
	"gopls",
	"bashls",
	"pyright",
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		autostart = true,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

--=======================================================
--     require lang modules with additional configs
--=======================================================
require("lsp.langs.sumneko_lua")
require("lsp.langs.jsonls")
require("lsp.langs.c")
require("lspconfig").clangd.setup({ capabilities = capabilities })
