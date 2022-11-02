local vim = vim
local nvim_lsp = require("lspconfig")
local lsp_util = require("safdar.lsp.lsp_util")
local capabilities = lsp_util.capabilities
local on_attach = lsp_util.on_attach

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
			schemas = require("schemastore").json.schemas(),
		},
	},
})
