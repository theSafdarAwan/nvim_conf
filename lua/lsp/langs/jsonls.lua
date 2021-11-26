local vim = vim
local nvim_lsp = require("lsp.lsp_util").nvim_lsp
local on_attach = require("core.plugins_mappings.lsp_map").on_attach
local capabilities = require("lsp.lsp_util").capabilities

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
