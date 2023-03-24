local nvim_lsp = require("lspconfig")
local utils = require("safdar.setup.lsp.utils")
local capabilities = require("safdar.setup.lsp.utils").capabilities
local on_attach = utils.on_attach

--=======================================================
--                      jsonls
--=======================================================
nvim_lsp.html.setup({
	...,
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		provideFormatter = false,
	},
})
