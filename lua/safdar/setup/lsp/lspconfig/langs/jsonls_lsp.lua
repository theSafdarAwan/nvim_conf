local vim = vim
local nvim_lsp = require("lspconfig")
local utils = require("safdar.setup.lsp.utils")
local capabilities = utils.capabilities
local on_attach = utils.on_attach

--=======================================================
--                      jsonls
--=======================================================
nvim_lsp.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
			end,
		},
	},
	settings = {
		json = {
			schemas = require("schemastore").json.schemas({}),
		},
	},
	init_options = {
		provideFormatter = false,
	},
})
