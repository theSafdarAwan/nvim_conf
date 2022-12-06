local nvim_lsp = require("lspconfig")
local lsp_util = require("safdar.lsp.lsp_util")
local capabilities = lsp_util.capabilities
local on_attach = lsp_util.on_attach

--=======================================================
--                      jsonls
--=======================================================
local bin_name = "ltex-ls"

nvim_lsp.ltex.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { bin_name },
	filetypes = {
		"tex",
		"markdown",
	},
})
