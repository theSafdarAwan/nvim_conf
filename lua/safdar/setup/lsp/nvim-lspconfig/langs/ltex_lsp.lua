local nvim_lsp = require("lspconfig")
local utils = require("safdar.setup.lsp.utils")
local capabilities = utils.capabilities
local on_attach = utils.on_attach

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
